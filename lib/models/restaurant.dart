import 'package:sim_teacommerce/models/food.dart';

class Restaurant {
  late String imageUrl;
  late String name;
  late String address;
  late int rating;
  late List<Food> menu;

  Restaurant({
    required this.imageUrl,
    required this.name,
    required this.address,
    required this.rating,
    required this.menu,
  });
}
