import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sim_teacommerce/controllers/cart_controller.dart';
import 'package:sim_teacommerce/controllers/user_controller.dart';

import 'package:sim_teacommerce/models/product.dart';

import 'package:sim_teacommerce/models/product_details.dart';
import 'package:sim_teacommerce/services/api.dart';

import '../constants.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({Key? key, required Product product})
      // ignore: prefer_initializing_formals
      : product = product,
        super(key: key);

  @override
  _ProductDetailsScreen createState() => _ProductDetailsScreen();
}

class _ProductDetailsScreen extends State<ProductDetailsScreen> {
  int cartQty = 0;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _fetchProductDetails(widget.product.id);
  }

  Widget _topSectionRestaurantSection(context) {
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

  Widget _infoRestaurantSection() {
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
          Text(
            widget.product.description,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 10.0,
            ),
          ),
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

                                    Get.find<CartController>()
                                        .updateProductCart(
                                            widget.product.id, cartQty);
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

                                    Get.find<CartController>()
                                        .updateProductCart(
                                            widget.product.id, cartQty);
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
                            Get.find<CartController>()
                                .adtoCart(widget.product.id, cartQty);

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
                      _topSectionRestaurantSection(context),
                      _infoRestaurantSection(),
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

                      // _menuItems(context),
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

      var accessToken = Get.find<UserController>().accessToken.toString();
      var params = {"ID": id.toString()};

      print(accessToken.toString());

      var response = await API().fetchdatawithParams(baseUrlWithoutHttp,
          productsDetails, {'accessToken': accessToken}, params);

      setState(() {
        loading = false;
      });

      print(response.body);
      var a = json.decode(response.body.toString());

      print("a  =>" + a.toString());

      if (response.statusCode == 200) {
        productDetails = ProductDetails.fromJson(a);
        setState(() {
          cartQty = productDetails.cartQty;
        });
      }
      print("a  =>" + productDetails.imageUrl);

      return productDetails;
    } catch (e) {
      print("Bad Request Error Message");
      e.printError();
      Get.snackbar("title", e.toString());
    }

    return productDetails;
  }
}
