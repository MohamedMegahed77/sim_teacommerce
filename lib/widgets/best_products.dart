import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sim_teacommerce/controllers/product_controller.dart';

import 'package:sim_teacommerce/models/product.dart';

class BestProducts extends StatelessWidget {
  // final ProductController _p = Get.put(ProductController());

  Widget _buildBestProduct(BuildContext context, Product product) {
    // final ProductController _p = Get.find<ProductController>();
    // _p.fetchBestProducts();

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
                product.imageUrl,
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
                  product.name,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  product.price.toString(),
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 4.0,
                ),
                Row(
                  children: List.generate(
                    product.rate,
                    (index) => Text(
                      "⭐️ ",
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Expanded(
          //   child: CircleAvatar(
          //     radius: 27.0,
          //     backgroundColor: Colors.deepOrangeAccent,
          //     child: Center(
          //       child: Icon(
          //         Icons.add,
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          // )
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
            "Best Products",
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
            child: Obx(
              () => ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount:
                    Get.find<ProductController>().bestproductsList.length,
                itemBuilder: (BuildContext context, int index) {
                  Product product =
                      Get.find<ProductController>().bestproductsList[index];
                  return _buildBestProduct(context, product);
                },
              ),
            )),
      ],
    );
  }
}
