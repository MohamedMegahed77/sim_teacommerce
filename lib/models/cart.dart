class CartModel {
  late int productID;
  late int qty;
  late String name;
  late double price;
  late double total;
  late String imageUrl;

  CartModel({
    required this.productID,
    required this.qty,
    required this.name,
    required this.price,
    required this.total,
    required this.imageUrl,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
        productID: json['productId'],
        qty: json['qty'],
        name: json['name'],
        price: double.parse(json['productPrice'].toString()),
        total: json['total'],
        imageUrl: json['productImgUrl']);
  }
}
