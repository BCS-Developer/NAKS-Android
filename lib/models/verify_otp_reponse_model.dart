import 'dart:convert';

VerifyOtpResponseModel verifyOtpResponseModelFromJson(String str) =>
    VerifyOtpResponseModel.fromJson(json.decode(str));

String verifyOtpResponseModelToJson(VerifyOtpResponseModel data) =>
    json.encode(data.toJson());

class VerifyOtpResponseModel {
  int? status;
  Result? result;

  VerifyOtpResponseModel({this.status, this.result});

  VerifyOtpResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  String? userId;
  String? isVerified;
  String? isRegistered;

  Result({this.userId, this.isVerified, this.isRegistered});

  Result.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    isVerified = json['is_verified'];
    isRegistered = json['is_registered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['is_verified'] = this.isVerified;
    data['is_registered'] = this.isRegistered;
    return data;
  }
}
