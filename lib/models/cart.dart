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
        productID: json['ProductID'],
        qty: json['Qty'],
        name: json['Name'],
        price: json['Price'],
        total: json['Total'],
        imageUrl: json['ImageUrl']);
  }
}
