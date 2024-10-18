import 'dart:convert';

LikeUpdateResponse likeUpdateResponseFromJson(String str) =>
    LikeUpdateResponse.fromJson(json.decode(str));

String likeUpdateResponseToJson(LikeUpdateResponse data) =>
    json.encode(data.toJson());

class LikeUpdateResponse {
  int? status;
  String? message;

  LikeUpdateResponse({this.status, this.message});

  LikeUpdateResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}
