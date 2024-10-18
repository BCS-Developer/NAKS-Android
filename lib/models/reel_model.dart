// ignore_for_file: unnecessary_this

import 'dart:convert';

ReelModel ReelModelFromJson(String str) => ReelModel.fromJson(json.decode(str));

String ReelModelToJson(ReelModel data) => json.encode(data.toJson());

class ReelModel {
  int? status;
  PaginationInfo? paginationInfo;
  List<Message>? message;

  ReelModel({this.status, this.paginationInfo, this.message});

  ReelModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    paginationInfo = json['pagination-info'] != null
        ? new PaginationInfo.fromJson(json['pagination-info'])
        : null;
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
    if (this.paginationInfo != null) {
      data['pagination-info'] = this.paginationInfo!.toJson();
    }
    if (this.message != null) {
      data['message'] = this.message!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaginationInfo {
  String? pageNumber;
  String? totalPosts;
  int? postsReturned;

  PaginationInfo({this.pageNumber, this.totalPosts, this.postsReturned});

  PaginationInfo.fromJson(Map<String, dynamic> json) {
    pageNumber = json['page_number'];
    totalPosts = json['total_posts'].toString();
    postsReturned = json['posts_returned'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page_number'] = this.pageNumber;
    data['total_posts'] = this.totalPosts;
    data['posts_returned'] = this.postsReturned;
    return data;
  }
}

class Message {
  String? postId;
  String? likes;
  String? categoryId;
  String? categoryName;
  String? subcategoryId;
  String? subcategoryName;
  String? assetType;
  AssetDetails? assetDetails;
  String? isLiked;

  Message(
      {this.postId,
      this.likes,
      this.categoryId,
      this.categoryName,
      this.subcategoryId,
      this.subcategoryName,
      this.assetType,
      this.assetDetails,
      this.isLiked});

  Message.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    likes = json['likes'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    subcategoryId = json['subcategoryId'];
    subcategoryName = json['subcategoryName'];
    assetType = json['asset_type'];
    assetDetails = json['asset_details'] != null
        ? new AssetDetails.fromJson(json['asset_details'])
        : null;
    isLiked = json['is_liked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postId'] = this.postId;
    data['likes'] = this.likes;
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    data['subcategoryId'] = this.subcategoryId;
    data['subcategoryName'] = this.subcategoryName;
    data['asset_type'] = this.assetType;
    if (this.assetDetails != null) {
      data['asset_details'] = this.assetDetails!.toJson();
    }
    data['is_liked'] = this.isLiked;
    return data;
  }
}

class AssetDetails {
  String? imageTitle;
  String? imageUrl;
  String? videoTitle;
  String? videoUrl;
  String? videoDescription;
  String? imageDescription;

  AssetDetails(
      {this.imageTitle,
      this.imageUrl,
      this.videoTitle,
      this.videoUrl,
      this.videoDescription,
      this.imageDescription});

  AssetDetails.fromJson(Map<String, dynamic> json) {
    imageTitle = json['imageTitle'];
    imageUrl = json['imageUrl'];
    videoTitle = json['videoTitle'];
    videoUrl = json['videoUrl'];
    videoDescription = json['videoDescription'];
    imageDescription = json['imageDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageTitle'] = this.imageTitle;
    data['imageUrl'] = this.imageUrl;
    data['videoTitle'] = this.videoTitle;
    data['videoUrl'] = this.videoUrl;
    data['videoDescription'] = this.videoDescription;
    data['imageDescription'] = this.imageDescription;
    return data;
  }
}
