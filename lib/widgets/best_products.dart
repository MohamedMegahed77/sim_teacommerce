import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sim_teacommerce/controllers/product_controller.dart';
import 'package:sim_teacommerce/models/category.dart';

import 'package:sim_teacommerce/models/product.dart';

class CategoriesListView extends StatelessWidget {
  List<Category> categories = [];
  CategoriesListView({required this.categories});

  Widget _buildcategoryitem(BuildContext context, Category category) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      width: 320,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          width: 1.0,
          color: Colors.grey[200]!,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                category.imgUrl,
                height: 100.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  category.name,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 4.0,
                ),
                SizedBox(
                  height: 4.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            "Categories",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Container(
            height: 120,
            padding: EdgeInsets.only(left: 10),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: this.categories.length,
              itemBuilder: (BuildContext context, int index) {
                Category category = this.categories[index];
                return _buildcategoryitem(context, category);
              },
            )),
      ],
    );
  }
}
