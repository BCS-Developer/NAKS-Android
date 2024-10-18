import 'dart:convert';

CategoryModel CategoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String CategoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  int? status;
  String? userId;
  List<Categories>? categories;
  List<Languages>? languages;

  CategoryModel({this.status, this.userId, this.categories, this.languages});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userId = json['user_id'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    if (json['languages'] != null) {
      languages = <Languages>[];
      json['languages'].forEach((v) {
        languages!.add(new Languages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['user_id'] = this.userId;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.languages != null) {
      data['languages'] = this.languages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  String? id;
  String? categoryName;
  String? count;
  int? isSelected;

  Categories({this.id, this.categoryName, this.count, this.isSelected});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['CategoryName'];
    count = json['Count'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['CategoryName'] = this.categoryName;
    data['Count'] = this.count;
    data['isSelected'] = this.isSelected;
    return data;
  }
}

class Languages {
  String? id;
  String? language;
  int? isSelected;

  Languages({this.id, this.language, this.isSelected});

  Languages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    language = json['language'];
    isSelected = json['is_selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['language'] = this.language;
    data['is_selected'] = this.isSelected;
    return data;
  }
}
