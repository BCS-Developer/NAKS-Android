import 'dart:convert';

AppUpdateResponseModel appUpdateResponseModelFromJson(String str) =>
    AppUpdateResponseModel.fromJson(json.decode(str));

String appUpdateResponseModelToJson(AppUpdateResponseModel data) =>
    json.encode(data.toJson());

class AppUpdateResponseModel {
  int? status;
  String? hardUpdate;
  String? softUpdate;
  String? message;

  AppUpdateResponseModel(
      {this.status, this.hardUpdate, this.softUpdate, this.message});

  AppUpdateResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    hardUpdate = json['HardUpdate'];
    softUpdate = json['SoftUpdate'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['HardUpdate'] = this.hardUpdate;
    data['SoftUpdate'] = this.softUpdate;
    data['message'] = this.message;
    return data;
  }
}
