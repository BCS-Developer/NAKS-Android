// ignore_for_file: unnecessary_new

class Posts {
  int? status;
  List<Message>? message;

  Posts({this.status, this.message, required String categoryName, required String subcategoryName});

  Posts.fromJson(Map<String, dynamic> json) {
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
  String? postid;
  String? title;
  String? description;
  String? categoryId;
  String? categoryName;
  String? subcategoryId;
  String? subcategoryName;

  Message(
      {this.postid,
      this.title,
      this.description,
      this.categoryId,
      this.categoryName,
      this.subcategoryId,
      this.subcategoryName});

  Message.fromJson(Map<String, dynamic> json) {
    postid = json['postid'];
    title = json['title'];
    description = json['description'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    subcategoryId = json['subcategoryId'];
    subcategoryName = json['subcategoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postid'] = this.postid;
    data['title'] = this.title;
    data['description'] = this.description;
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    data['subcategoryId'] = this.subcategoryId;
    data['subcategoryName'] = this.subcategoryName;
    return data;
  }
}