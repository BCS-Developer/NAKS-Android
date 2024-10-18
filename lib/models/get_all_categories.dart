// models/category.dart

class Category {
  final String id;
  final String categoryName;
  final int postCount;

  Category({
    required this.id,
    required this.categoryName,
    required this.postCount,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      categoryName: json['CategoryName'],
      postCount: json['Posts'],
    );
  }
}
