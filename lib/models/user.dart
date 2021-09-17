import 'package:sim_teacommerce/models/order.dart';

class User {
  late String name;
  late List<Order> orders;
  late List<Order> cart;

  User({
    required this.name,
    required this.orders,
    required this.cart,
  });
}
