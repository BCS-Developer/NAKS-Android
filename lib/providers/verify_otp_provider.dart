import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:top_examer/models/verify_otp_reponse_model.dart';

import '../utils/constants.dart';
import '../utils/shared_preference_utils.dart';

class VerifyOTPProvider with ChangeNotifier {
  bool isLoading = false;
  VerifyOtpResponseModel? verifyOtpModel;
  String? error;

  // Send OTP to mobile number
  Future<VerifyOtpResponseModel?> verifyOTP(String mobile, String otp) async {
    try {
      isLoading = true;
      notifyListeners();

      var url = Uri.https(AppConstants.baseUrl, AppConstants.apiUrl,
          {'key': AppConstants.otpVerification});

      final req = http.MultipartRequest('POST', url)
        ..fields['mobile_no'] = mobile.substring(2)
        ..fields['otp'] = otp;

      final stream = await req.send();
      final response = await http.Response.fromStream(stream)
          .timeout(const Duration(seconds: AppConstants.HTTP_TIME_OUT));
      final status = response.statusCode;
      print("RRR req " + url.toString());
      print("RRR res " + jsonDecode(response.body).toString());
      if (status == 200) {
        if (response.body.isNotEmpty) {
          verifyOtpModel = verifyOtpResponseModelFromJson(response.body);
          if (verifyOtpModel?.result?.isVerified == "1" &&
              verifyOtpModel?.result?.isRegistered == "1") {
            await SharedPreferenceUtils.saveStringToSP(AppConstants.USER_ID,
                verifyOtpModel?.result?.userId?.toString() ?? "0");
          }
          debugPrint(response.reasonPhrase);
        } else {
          debugPrint(response.reasonPhrase);
        }
      }
    } catch (e) {
      isLoading = false;
      error = AppConstants.unknownError;
      notifyListeners();
      debugPrint(e.toString());
    }
    isLoading = false;
    notifyListeners();
    return verifyOtpModel;
  }
}
