import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:top_examer/models/profile_details_model.dart';
import 'package:top_examer/providers/verify_otp_provider.dart';
import 'package:top_examer/utils/shared_preference_utils.dart';

import '../common_widgets/common-widgets.dart';
import '../models/LanguagesModel.dart';
import '../utils/constants.dart';

class ProfileProvider extends ChangeNotifier {
  bool isLoading = false;
  String name = '';
  String email = '';
  String phone = '';
  String city = '';
  String state = '';
  String country = '';
  String? gender = '';
  String? dob = '';
  String? categoryPreference;
  String? languagePreference;

  ProfileDetailsModel? profileDetailsModel;
  LanguagesModel? languagesModel;

  bool _editModeEnabled = false;
  bool get editModeEnabled => _editModeEnabled;
  set editModeEnabled(bool isVisible) {
    _editModeEnabled = isVisible;
    notifyListeners();
  }

  Future<bool> signUpOrupdateProfile(
      bool isFirstTime, BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      var url = Uri.https(AppConstants.baseUrl, AppConstants.apiUrl, {
        'key': isFirstTime ? AppConstants.signUp : AppConstants.updateProfileUrl
      });

      String userId = "";
      if (isFirstTime) {
        VerifyOTPProvider verifyOTPProvider =
            Provider.of<VerifyOTPProvider>(context, listen: false);
        userId = verifyOTPProvider.verifyOtpModel?.result?.userId ?? "";
      } else {
        userId = (await SharedPreferenceUtils.getStringFromSp(
            AppConstants.USER_ID))!;
      }
      String genderTemp =
          gender != null && gender != "Gender" ? gender!.toLowerCase() : "";
      var req = http.MultipartRequest('POST', url)
        ..fields['name'] = name
        ..fields['email'] = email
        ..fields['userId'] = userId
        ..fields['gender'] = genderTemp
        ..fields['dob'] = dob!;

      final stream = await req.send();
      final response = await http.Response.fromStream(stream)
          .timeout(const Duration(seconds: AppConstants.HTTP_TIME_OUT));
      print("RRR " + jsonDecode(response.body).toString());
      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        new CommonWidgets().showSnackbar(jsonResponse["message"], context);

        isLoading = false;
        notifyListeners();

        return true;
      } else {
        new CommonWidgets().showSnackbar(jsonResponse["message"], context);
      }
    } catch (e) {
      new CommonWidgets().showSnackbar(AppConstants.unknownError, context);
      debugPrint(e.toString());
    }
    isLoading = false;
    notifyListeners();
    return false;
  }

   Future<bool> getProfileDetails(BuildContext context) async {
    try {
      var userId =
          await SharedPreferenceUtils.getStringFromSp(AppConstants.USER_ID);
      isLoading = true;
      notifyListeners();

      var url = Uri.https(AppConstants.baseUrl, AppConstants.apiUrl,
          {'key': AppConstants.getProfileDetails, 'userId': userId!});

      final response = await http
          .get(url)
          .timeout(const Duration(seconds: AppConstants.HTTP_TIME_OUT));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        profileDetailsModel = ProfileDetailsModel.fromJson(data);

        // Update fields using profileDetailsModel.message
        if (profileDetailsModel?.message != null) {
          name = profileDetailsModel?.message?.fullname ?? '';
          email = profileDetailsModel?.message?.email ?? '';
          phone = profileDetailsModel?.message?.phonenumber ?? '';
          city = ''; // Update this based on your actual data structure
          state = ''; // Update this based on your actual data structure
          country = ''; // Update this based on your actual data structure
          gender = profileDetailsModel?.message?.gender;
          dob = profileDetailsModel?.message?.dob;
          categoryPreference = profileDetailsModel?.message?.preferences?.category;
          languagePreference = profileDetailsModel?.message?.preferences?.language;
        }

        isLoading = false;
        notifyListeners();
        return true;
      } else {
        isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> getLanguages(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      var url = Uri.https(AppConstants.baseUrl, AppConstants.apiUrl,
          {'key': AppConstants.getAllLanguages});

      final response = await http
          .get(url)
          .timeout(const Duration(seconds: AppConstants.HTTP_TIME_OUT));
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
  }
}
