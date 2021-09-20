import 'dart:convert';

List<Category> categoryFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

class Category {
  late int id;
  late String imgUrl;
  late String name;

  Category({required this.id, required this.imgUrl, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json['id'], name: json['name'], imgUrl: json['imgUrl']);
  }
}
