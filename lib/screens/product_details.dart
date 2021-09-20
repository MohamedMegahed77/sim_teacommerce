import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sim_teacommerce/controllers/cart_controller.dart';
import 'package:sim_teacommerce/controllers/usercontroller.dart';

import 'package:sim_teacommerce/models/product.dart';

import 'package:sim_teacommerce/models/product_details.dart';
import 'package:sim_teacommerce/services/api.dart';

import '../constants.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({Key? key, required Product product})
      : product = product,
        super(key: key);

  @override
  _ProductDetailsScreen createState() => _ProductDetailsScreen();
}

class _ProductDetailsScreen extends State<ProductDetailsScreen> {
  int cartQty = 0;
  bool loading = true;
  String ActionUrl = addtoCart;

  @override
  void initState() {
    super.initState();
    _fetchProductDetails(widget.product.id);
  }

  Future<int> adtoCart(int ProductID, int Qty) async {
    try {
      var accessToken = Get.find<UserController>().user.value.token.toString();
      print("accessToken()  => $accessToken ");

      var headers = <String, String>{
        "Authorization": "Bearer $accessToken",
        'Content-Type': 'application/json; charset=UTF-8',
      };

      var body = jsonEncode(<String, int>{"productId": ProductID, "qty": Qty});

      var response =
          await API().postData(baseUrlWithoutHttp, ActionUrl, headers, body);

      ActionUrl = updateProductCartUrl;

      int statusCode = response.statusCode;
      return statusCode;
    } catch (e) {
      return 400;
    }
  }

  Widget _topSectionProductDetails(context) {
    return Stack(
      children: [
        Hero(
          tag: Key(widget.product.imageUrl),
          child: Image.network(
            widget.product.imageUrl,
            height: 220.0,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SafeArea(
                child: IconButton(
                  iconSize: 28.0,
                  color: Colors.white,
                  onPressed: () => Get.back(),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                  ),
                ),
              ),
              // SafeArea(
              //   child: IconButton(
              //     iconSize: 30.0,
              //     color: Theme.of(context).primaryColor,
              //     onPressed: () {},
              //     icon: Icon(
              //       Icons.favorite,
              //     ),
              //   ),
              // ),
            ],
          ),
        )
      ],
    );
  }

  Widget __infoProductDetailsSection() {
    // setState(() {
    //   cartQty = cartQty;
    // });

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.product.name,
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: List.generate(
              widget.product.rate,
              (index) => const Text(
                "⭐️ ",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            widget.product.categoryName,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          // Text(
          //   widget.product.description,
          //   style: const TextStyle(
          //     fontWeight: FontWeight.w600,
          //     fontSize: 10.0,
          //   ),
          // ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 120,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Reviews"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrangeAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              (cartQty > 0)
                  ? Container(
                      width: 120.0,
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          width: 0.8,
                          color: Colors.black54,
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    cartQty =
                                        (cartQty == 1) ? 1 : (cartQty - 1);

                                    adtoCart(widget.product.id, cartQty);
                                  });
                                },
                                child: const Text(
                                  '-',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 25),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            Text(
                              "$cartQty",
                              style: const TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            InkWell(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    cartQty += 1;

                                    adtoCart(widget.product.id, cartQty);
                                  });
                                },
                                child: const Text(
                                  '+',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 25),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : SizedBox(
                      width: 120,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            cartQty += 1;
                            adtoCart(widget.product.id, cartQty);
                          });
                        },
                        child: const Text("Add To Cart"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepOrangeAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: (loading)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _topSectionProductDetails(context),
                      __infoProductDetailsSection(),
                      const SizedBox(
                        height: 10,
                      ),
                      const Center(
                        child: Text(
                          "Menu",
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      //  _menuItems(context),
                    ],
                  ),
                ),
              ));
  }

  Future<ProductDetails> _fetchProductDetails(id) async {
    late ProductDetails productDetails;

    try {
      setState(() {
        loading = true;
      });

      var accessToken = Get.find<UserController>().user.value.token.toString();
      var params = {"id": id.toString()};

      print(accessToken.toString());

      var response = await API().fetchdatawithParams(baseUrlWithoutHttp,
          productsDetails, {'Authorization': "Bearer  $accessToken"}, params);

      setState(() {
        loading = false;
      });

      var jsonResult = json.decode(response.body.toString());

      if (response.statusCode == 200) {
        print("jsonResult" + jsonResult["product"].toString());

        // int id = jsonResult["product"]["id"];
        // int cartQty = jsonResult["product"]["cartQty"];
        // double price = jsonResult["product"]["price"];

        // int rnd = Random().nextInt(5);

        // print("id $id");
        // print("cartQty $cartQty");
        // print("price $price");
        // print("rnd ${rnd}");

        productDetails = ProductDetails.fromJson(jsonResult["product"]);

        setState(() {
          cartQty = productDetails.cartQty;
          if (cartQty > 0) {
            ActionUrl = updateProductCartUrl;
          }
        });
      }

      return productDetails;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
    return productDetails;
  }
}
