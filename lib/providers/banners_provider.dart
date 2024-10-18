import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:top_examer/models/banner_model.dart';
import 'package:top_examer/utils/constants.dart';
import 'package:top_examer/utils/helper.dart';

import '../utils/shared_preference_utils.dart';

class BannersProvider extends ChangeNotifier {
  bool isLoading = true;
  BannersModel? bannersModel;

  getReelIdFromUrl(String url) {
    Uri uri = Uri.parse(url);
    String? nid = uri.queryParameters['nid'];
    if (nid != null) {
      SharedPreferenceUtils.saveBoolToSP(
          AppConstants.IS_APPLINK_NAVIGATED, true);
      SharedPreferenceUtils.saveStringToSP(
          AppConstants.POST_ID, nid.toString());
    }

    return nid;
  }

  Future<BannersModel?> getBanners(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();
      var url = Uri.https(AppConstants.baseUrl, AppConstants.apiUrl,
          {'key': AppConstants.bannersUrl});

      var response = await http
          .get(url, headers: getHeaders())
          .timeout(const Duration(seconds: AppConstants.HTTP_TIME_OUT));
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          bannersModel = bannersModelFromJson(response.body);
          if (bannersModel!.message.length > 10) {
            bannersModel!.message = bannersModel!.message.sublist(0, 10);
          }
          debugPrint(response.reasonPhrase);
        } else {
          debugPrint(response.reasonPhrase);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    isLoading = false;
    notifyListeners();
    return bannersModel;
  }
}
