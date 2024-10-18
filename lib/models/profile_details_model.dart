import 'dart:convert';

ProfileDetailsModel profileDetailsModelFromJson(String str) =>
    ProfileDetailsModel.fromJson(json.decode(str));

String profileDetailsModelToJson(ProfileDetailsModel data) =>
    json.encode(data.toJson());

class ProfileDetailsModel {
  int? status;
  Message? message;

  ProfileDetailsModel({this.status, this.message});

  ProfileDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message =
        json['message'] != null ? new Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    return data;
  }
}

class Message {
  String? fullname;
  String? dob;
  String? email;
  String? phonenumber;
  String? gender;
  Preferences? preferences;

  Message(
      {this.fullname,
      this.dob,
      this.email,
      this.phonenumber,
      this.gender,
      this.preferences});

  Message.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    dob = json['dob'];
    email = json['email'];
    phonenumber = json['phonenumber'];
    gender = json['gender'];
    preferences = json['preferences'] != null
        ? new Preferences.fromJson(json['preferences'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = this.fullname;
    data['dob'] = this.dob;
    data['email'] = this.email;
    data['phonenumber'] = this.phonenumber;
    data['gender'] = this.gender;
    if (this.preferences != null) {
      data['preferences'] = this.preferences!.toJson();
    }
    return data;
  }
}

class Preferences {
  String? category;
  String? language;
  String? advertisements;

  Preferences({this.category, this.language, this.advertisements});

  Preferences.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    language = json['language'];
    advertisements = json['advertisements'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['language'] = this.language;
    data['advertisements'] = this.advertisements;
    return data;
  }
}
