import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sim_teacommerce/controllers/product_controller.dart';
import 'package:sim_teacommerce/models/product.dart';
import 'package:sim_teacommerce/screens/product_details.dart';

class ProductsListView extends StatelessWidget {
  List<Product> products = [];

  ProductsListView({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildProducts(context) {
      List<Widget> restaurantList = [];
      this.products.forEach((product) {
        restaurantList.add(GestureDetector(
          onTap: () {
            Get.to(ProductDetailsScreen(product: product));
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 140,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 1.0, color: Colors.grey[200]!)),
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Hero(
                      tag: Key(
                        product.imageUrl,
                      ),
                      child: Image.network(
                        product.imageUrl,
                        height: 140,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: List.generate(
                          product.rate,
                          (index) => Text(
                            "⭐️ ",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "\$${product.price}",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ));
      });

      return Column(
        children: restaurantList,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Products",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
          _buildProducts(context),
        ],
      ),
    );
  }
}
