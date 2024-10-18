import 'dart:convert';

BannersModel bannersModelFromJson(String str) =>
    BannersModel.fromJson(json.decode(str));

String bannersModelToJson(BannersModel data) => json.encode(data.toJson());

class BannersModel {
  BannersModel({
    required this.status,
    required this.message,
  });
  late final int status;
  late final List<Message> message;

  BannersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message =
        List.from(json['message']).map((e) => Message.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Message {
  Message({
    required this.imageName,
    required this.pageName,
    required this.postUrl,
    required this.imageUrl,
  });
  late final String imageName;
  late final String pageName;
  late final String postUrl;
  late final String imageUrl;

  Message.fromJson(Map<String, dynamic> json) {
    imageName = json['image_name'];
    pageName = json['page_name'];
    postUrl = json['post_url'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['image_name'] = imageName;
    _data['page_name'] = pageName;
    _data['post_url'] = postUrl;
    _data['image_url'] = imageUrl;
    return _data;
  }
}
