import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multi_dropdown/models/value_item.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:top_examer/models/AppUpdateResponseModel.dart';
import 'package:top_examer/models/category_model.dart';
import 'package:top_examer/providers/global_provider.dart';
import 'package:top_examer/utils/constants.dart';

import '../common_widgets/common-widgets.dart';
import '../ui/categories_page/select_categories_page.dart';
import '../utils/helper.dart';
import '../utils/shared_preference_utils.dart';

class CategoriesProvider with ChangeNotifier {
  CategoryModel? model;
  AppUpdateResponseModel? appUpdateResponseModel;
  bool isLoading = false;
  List<int> selectedCategories = [];
  List<ValueItem<Languages>> selectedLanguages = [];

  isCategoriesModified(List<int> original, List<int> modified) {
    if (original.length != modified.length) {
      return true;
    }
    for (int i = 0; i < original.length; i++) {
      if (modified.indexOf(original[i]) == -1) {
        return true;
      }
    }

    return false;
  }

  isLanguagesModified(List<ValueItem<Languages>> original,
      List<ValueItem<Languages>> modified) {
    if (original.length != modified.length) {
      return true;
    }
    for (int i = 0; i < original.length; i++) {
      bool isExists =
          modified.any((model) => model.value?.id == original[i].value?.id);
      if (!isExists) {
        return true;
      }
    }

    return false;
  }

  updateSelectedList(String catId) {
    if (isInteger(catId)) {
      var id = int.parse(catId);
      if (!selectedCategories.contains(id)) {
        selectedCategories.add(id);
      } else {
        selectedCategories.remove(id);
      }
      notifyListeners();
    }
  }

  addToSelectedList(String catId) {
    if (isInteger(catId)) {
      var id = int.parse(catId);
      if (!selectedCategories.contains(id)) {
        selectedCategories.add(id);
      }
      notifyListeners();
    }
  }

  updateSelectedLanguages() {
    //if (isInteger(langId)) {
    selectedLanguages.clear();
    if (model?.languages != null) {
      for (var item in model!.languages ?? <ValueItem<Languages>>[]) {
        if (item != null && (item as Languages).isSelected == 1) {
          selectedLanguages.add(ValueItem(
              label: (item as Languages).language ?? "", value: item));
        }
      }
    }
    notifyListeners();
  }

  getSelectedLanguagesIds() {
    var ids = [];
    for (var item in selectedLanguages) {
      ids.add(item.value?.id);
    }

    return ids.join(",");
  }

  isCategorySelected(String catId) {
    if (isInteger(catId)) {
      var id = int.parse(catId);
      return selectedCategories.contains(id);
    }
    return false;
  }

  Future<void> getCategories(
      bool enableSelectMode, BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();
      var userId =
          (await SharedPreferenceUtils.getStringFromSp(AppConstants.USER_ID))!;
      var url = Uri.https(AppConstants.baseUrl, AppConstants.apiUrl,
          {'key': AppConstants.categoriesUrl, 'userId': userId!});
      var response = await http
          .get(url, headers: getHeaders())
          .timeout(const Duration(seconds: AppConstants.HTTP_TIME_OUT));
      print("RRR req " + url.toString());
      print("RRR res " + jsonDecode(response.body).toString());
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          model = CategoryModelFromJson(response.body);
          updateSelectedLanguages();
          selectedCategories.clear();
          model?.categories?.forEach((i) {
            if (i?.isSelected == 1) {
              addToSelectedList(i?.id ?? "");
            }
          });
        } else {
          //throw Exception(response.reasonPhrase);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e.toString());
    }
    isLoading = false;
    notifyListeners();

    if (!enableSelectMode && selectedCategories.length == 0) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => SelectCategories(),
        ),
      );
    }
    //return model;
  }

  Future<AppUpdateResponseModel?> checkApiUpdate(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      var platform = Platform.isAndroid ? 'android' : 'ios';

      var url = Uri.https(AppConstants.baseUrl, AppConstants.apiUrl, {
        'key': AppConstants.appUpdateApi,
        'platform': platform,
        'app_version': packageInfo.version
      });

      var response = await http
          .get(url)
          .timeout(const Duration(seconds: AppConstants.HTTP_TIME_OUT));
      ;
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          appUpdateResponseModel =
              appUpdateResponseModelFromJson(response.body);
        } else {
          throw Exception(response.reasonPhrase);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      //throw Exception(e.toString());
    }
    isLoading = false;
    notifyListeners();
    return appUpdateResponseModel;
  }

  Future<bool> updateSelectedCategories(BuildContext context) async {
    try {
      var userId =
          await SharedPreferenceUtils.getStringFromSp(AppConstants.USER_ID);

      isLoading = true;
      notifyListeners();
      var url = Uri.https(AppConstants.baseUrl, AppConstants.apiUrl,
          {'key': AppConstants.updatePreferences});
      final req = http.MultipartRequest('POST', url)
        ..fields['cat'] = selectedCategories.join(',')
        ..fields['lang'] = getSelectedLanguagesIds()
        ..fields['ad'] = "1"
        ..fields['userId'] = userId ?? "";

      final stream = await req.send();
      final response = await http.Response.fromStream(stream)
          .timeout(const Duration(seconds: AppConstants.HTTP_TIME_OUT));

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          var jsonResponse = jsonDecode(response.body);
          new CommonWidgets().showSnackbar(jsonResponse["message"], context);
          // Update langId in GlobalProvider
          var globalProvider =
              Provider.of<GlobalProvider>(context, listen: false);
          globalProvider.setLangId(getSelectedLanguagesIds());

          isLoading = false;
          notifyListeners();
          return true;
        } else {
          new CommonWidgets().showSnackbar(AppConstants.unknownError, context);
          throw Exception(response.reasonPhrase);
        }
      }
    } catch (e) {
      new CommonWidgets().showSnackbar(AppConstants.unknownError, context);
      debugPrint(e.toString());
      throw Exception(e.toString());
    }
    isLoading = false;
    notifyListeners();
    return true;
  }
/*
  Future<bool> getLanguages(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      var url = Uri.https(AppConstants.baseUrl, AppConstants.apiUrl,
          {'key': AppConstants.getAllLanguages});

      final response = await http
          .get(url)
          .timeout(const Duration(seconds: AppConstants.HTTP_TIME_OUT));
      ;
      if (response.statusCode == 200) {
        languagesModel = languagesModelFromJson(response.body);
        isLoading = false;
        notifyListeners();

        return true;
      } else {
        new CommonWidgets().showSnackbar(AppConstants.unknownError, context);
      }
    } catch (e) {
      new CommonWidgets().showSnackbar(AppConstants.unknownError, context);
      debugPrint(e.toString());
    }

    isLoading = false;
    notifyListeners();
    return false;
  }*/
}
