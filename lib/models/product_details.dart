import 'dart:math';

class ProductDetails {
  late int id;
  late int cartQty;
  late String name;
  late String fullName;
  late String description;
  late int rate;
  late String categoryName;
  late String origin;
  late String imageUrl;
  late double price;

  ProductDetails({
    required this.id,
    required this.cartQty,
    required this.name,
    required this.fullName,
    //required this.description,
    required this.rate,
    //required this.categoryName,
    //required this.origin,
    required this.imageUrl,
    required this.price,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      id: json['id'],
      cartQty: json['cartQty'],
      name: json['name'],
      fullName: json['name'],
      rate: Random().nextInt(5),
      imageUrl: json['imgUrl'],
      price: json['price'],
    );
  }
}
