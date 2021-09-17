import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:sim_teacommerce/controllers/cart_controller.dart';
import 'package:sim_teacommerce/controllers/product_controller.dart';
import 'package:sim_teacommerce/controllers/user_controller.dart';
import 'package:sim_teacommerce/models/cart.dart';
import 'package:sim_teacommerce/models/product.dart';
import 'package:sim_teacommerce/screens/screens.dart';
import 'package:sim_teacommerce/services/api.dart';
import 'package:sim_teacommerce/widgets/best_products.dart';
import 'package:sim_teacommerce/widgets/widgets.dart';

import '../constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static Future<void> sendTest() async {
    try {
      var accessToken = Get.find<UserController>().accessToken.toString();

      var headers = <String, String>{
        "accessToken": accessToken,
        'Content-Type': 'application/json; charset=UTF-8',
      };

      var body = jsonEncode(<String, int>{"ProductID": 1, "Qty": 2});

      var response =
          await API().postData(baseUrlWithoutHttp, testUrl, headers, body);

      print("response.statusCode ()" + response.statusCode.toString());

      if (response.statusCode == 200) {
        print("response.body" + response.body.toString());
      }
    } catch (e) {
      print("Bad Request Error Message");
      e.printError();
      Get.snackbar("title", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final ProductController _p = Get.put(ProductController());
    final UserController _u = Get.put(UserController());
    final CartController _cart = Get.put(CartController());

    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("ECommerce App ", style: TextStyle(fontSize: 20)),
            leading: IconButton(
              icon: Icon(Icons.sync),
              onPressed: () {
                Get.snackbar("Sync", "Sync");
                sendTest();
                // Get.find<ProductController>().fetchAllProducts();
                // Get.find<ProductController>().fetchBestProducts();
              },
              iconSize: 30,
            ),
            actions: [
              TextButton(
                  onPressed: () => Get.to(CartScreen()),
                  child: Icon(Icons.shopping_cart, color: Colors.white))
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              Get.find<ProductController>().fetchAllProducts();
              Get.find<ProductController>().fetchBestProducts();
            },
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child:
                        // TextField(
                        //   decoration: InputDecoration(
                        //     fillColor: Colors.white,
                        //     filled: true,
                        //     contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                        //     enabledBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(30.0),
                        //       borderSide: BorderSide(width: 0.8),
                        //     ),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(30.0),
                        //       borderSide: BorderSide(
                        //           width: 0.8, color: Colors.deepOrangeAccent),
                        //     ),
                        //     hintText: 'Search Products',
                        //     prefixIcon: Icon(
                        //       Icons.search,
                        //       size: 30.0,
                        //     ),
                        //     suffixIcon: IconButton(
                        //       icon: Icon(Icons.clear),
                        //       onPressed: () {},
                        //     ),
                        //   ),
                        // ),
                        TypeAheadField(
                      textFieldConfiguration: const TextFieldConfiguration(
                          autofocus: false,
                          style: TextStyle(fontSize: 16),
                          decoration:
                              InputDecoration(border: OutlineInputBorder())),
                      suggestionsCallback: (pattern) async {
                        return await Get.find<ProductController>().searchProducts(pattern);
                      },
                      itemBuilder: (context, suggestion) {
                        var product = suggestion as Product;
                        return ListTile(
                          leading: Image.network(product.imageUrl),
                          title: Text("${product.name}"),
                          subtitle: Text('\$${product.price}'),

                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        var product = suggestion as Product;
                        Get.to(ProductDetailsScreen(product: product));
                        
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) =>
                        //         ProductPage(product: suggestion)));
                      },
                    )),
                BestProducts(),
                ProductsListView(),
              ],
            ),
          ),
        ));
  }
}
