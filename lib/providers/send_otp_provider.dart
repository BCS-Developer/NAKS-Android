import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:top_examer/models/send_otp_response_model.dart';
import 'package:top_examer/utils/constants.dart';
import 'package:flutter/material.dart';
 

class SendOTPProvider with ChangeNotifier {
  bool isLoading = false;
  late SendOtpResponseModel otpModel;
  String? error;
  late String mobileNumber;

  void setError(String? error) {
    this.error = error;
    notifyListeners();
  }

  // Send OTP to mobile number
  Future<SendOtpResponseModel> sendOTP(String mobile) async {
    mobileNumber = '91$mobile';
    try {
      isLoading = true;
      notifyListeners();

      var url = Uri.https(AppConstants.baseUrl, AppConstants.apiUrl,
          {'key': AppConstants.sendOtp});

      final req = http.MultipartRequest('POST', url)
        ..fields['mobile_no'] = mobile;

      final stream = await req.send();
      final response = await http.Response.fromStream(stream)
          .timeout(const Duration(seconds: AppConstants.HTTP_TIME_OUT));
      final status = response.statusCode;
      if (status == 200) {
        if (response.body.isNotEmpty) {
          otpModel = sendOtpResponseModelFromJson(response.body);
          debugPrint(response.reasonPhrase);
        } else {
          debugPrint(response.reasonPhrase);
        }
      }
    } catch (e) {
      isLoading = false;
      setError(AppConstants.unknownError);
      debugPrint(e.toString());
    }
    isLoading = false;
    notifyListeners();
    return otpModel;
  }
}
