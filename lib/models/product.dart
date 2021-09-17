import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

class Product {
  late int id;
  late String name;
  late String fullName;
  late String description;
  late int rate;
  late String categoryName;
  late String origin;
  late String imageUrl;
  late double price;

  Product({
    required this.id,
    required this.name,
    required this.fullName,
    required this.description,
    required this.rate,
    required this.categoryName,
    required this.origin,
    required this.imageUrl,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['ID'],
        name: json['Name'],
        fullName: json['FullName'],
        description: json['Description'],
        rate: json['Rate'],
        categoryName: json['CategoryName'],
        origin: json['Origin'],
        imageUrl: json['ImageUrl'],
        price: json['Price']);
  }

  static Product convertBody(element) {
    return Product(
        id: element['ID'] as int,
        name: element['Name'] as String,
        fullName: element['FullName'] as String,
        description: element['Description'] as String,
        rate: element['Rate'] as int,
        categoryName: element['CategoryName'] as String,
        origin: element['Origin'] as String,
        imageUrl: element['ImageUrl'] as String,
        price: element['Price'] as double);
  }
}
