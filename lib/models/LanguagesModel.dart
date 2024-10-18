import 'dart:convert';

LanguagesModel languagesModelFromJson(String str) =>
    LanguagesModel.fromJson(json.decode(str));

String languagesModelToJson(LanguagesModel data) => json.encode(data.toJson());

class LanguagesModel {
  int? status;
  List<Message>? message;

  LanguagesModel({this.status, this.message});

  LanguagesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['message'] != null) {
      message = <Message>[];
      json['message'].forEach((v) {
        message!.add(new Message.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.message != null) {
      data['message'] = this.message!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Message {
  String? id;
  String? language;
  String? createdDate;
  String? modifiedDate;
  String? isActive;

  Message(
      {this.id,
      this.language,
      this.createdDate,
      this.modifiedDate,
      this.isActive});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    language = json['language'];
    createdDate = json['created_date'];
    modifiedDate = json['modified_date'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['language'] = this.language;
    data['created_date'] = this.createdDate;
    data['modified_date'] = this.modifiedDate;
    data['is_active'] = this.isActive;
    return data;
  }
}
