import 'package:sim_teacommerce/models/restaurant.dart';

import 'food.dart';

class Order {
  late Restaurant restaurant;
  late Food food;
  late String date;
  late int quantity;

  Order({
    required this.date,
    required this.restaurant,
    required this.food,
    required this.quantity,
  });
  Order copyWith(
      {Restaurant? inputRestaurant,
      Food? inputFood,
      String? inputDate,
      int? inputQuantity}) {
    return Order(
        restaurant: this.restaurant,
        food: inputFood ?? this.food,
        date: inputDate ?? this.date,
        quantity: inputQuantity ?? this.quantity);
  }
}
