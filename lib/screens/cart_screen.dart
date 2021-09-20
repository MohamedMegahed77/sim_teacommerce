import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sim_teacommerce/constants.dart';
import 'package:sim_teacommerce/controllers/cart_controller.dart';
import 'package:sim_teacommerce/controllers/usercontroller.dart';
import 'package:sim_teacommerce/data/data.dart';
import 'package:sim_teacommerce/models/cart.dart';
import 'package:sim_teacommerce/models/models.dart';
import 'package:sim_teacommerce/services/api.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<CartModel> cartList;

  double totalCost = 0;
  int cartLength = 0;

  @override
  void initState() {
    super.initState();

    fetchCartList();
  }

  Future<void> fetchCartList() async {
    var accessToken =
        Get.find<UserController>().user.value.token.toString().toString();

    print("accessToken => $accessToken");
    var headers = <String, String>{
      "Authorization": "Bearer $accessToken",
      'Content-Type': 'application/json',
    };

    var response = await API().fetchdata(baseUrlWithoutHttp, cartAll, headers);

    if (response.statusCode == 200) {
      print("response  => " + response.body.toString());
      List jsonResponse = json.decode(response.body);

      cartList =
          jsonResponse.map((element) => CartModel.fromJson(element)).toList();

      setState(() {
        cartList = cartList;
        cartLength = cartList.length;

        print("initState()  cartList length => " + cartList.length.toString());

        updateTotalCost();
      });
    } else {
      Get.snackbar("Error", response.headers["ErrorMessage"].toString());
    }
  }

  void updateTotalCost() {
    setState(() {
      for (CartModel e in cartList) {
        totalCost += e.total;
      }
    });
  }

  Future<int> updatecart(int ProductID, int Qty) async {
    try {
      var accessToken = Get.find<UserController>().user.value.token.toString();
      print("accessToken()  => $accessToken ");

      var headers = <String, String>{
        "Authorization": "Bearer $accessToken",
        'Content-Type': 'application/json; charset=UTF-8',
      };

      var body = jsonEncode(<String, int>{"productId": ProductID, "qty": Qty});

      var response = await API()
          .postData(baseUrlWithoutHttp, updateProductCartUrl, headers, body);

      int statusCode = response.statusCode;
      return statusCode;
    } catch (e) {
      return 400;
    }
  }

  Widget _buildCartItem(CartModel cartProduct) {
    return Container(
      height: 140,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[200]!, width: 1.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                cartProduct.imageUrl,
                height: 140,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  cartProduct.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Price : \$${cartProduct.price}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 150.0,
                  padding: EdgeInsets.only(right: 10, left: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      width: 0.8,
                      color: Colors.black54,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        child: GestureDetector(
                          onTap: () {
                            setState(() async {
                              cartProduct.qty = (cartProduct.qty == 1)
                                  ? 1
                                  : (cartProduct.qty - 1);

                              await updatecart(
                                  cartProduct.productID, cartProduct.qty);

                              // Get.find<CartController>().updateProductCart(
                              //     cartProduct.productID, cartProduct.qty);

                              cartProduct.total =
                                  cartProduct.qty * cartProduct.price;

                              updateTotalCost();
                            });
                          },
                          child: const Text(
                            '-',
                            style: TextStyle(color: Colors.red, fontSize: 25),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Text(
                        "${cartProduct.qty}",
                        style: const TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      InkWell(
                        child: GestureDetector(
                          onTap: () {
                            setState(() async {
                              cartProduct.qty += 1;
                              await updatecart(
                                  cartProduct.productID, cartProduct.qty);

                              // Get.find<CartController>().updateProductCart(
                              //     cartProduct.productID, cartProduct.qty);

                              cartProduct.total =
                                  cartProduct.qty * cartProduct.price;

                              updateTotalCost();
                            });
                          },
                          child: const Text(
                            '+',
                            style: TextStyle(color: Colors.red, fontSize: 25),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text(
            '\$${cartProduct.total.toString()}',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _totalPrice = 0;
    currentUser.cart
        .forEach((order) => _totalPrice += order.food.price * order.quantity);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
          iconSize: 25,
        ),
        title: Text(
          "Cart ( $cartLength )",
        ),
      ),
      body: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            if (index < cartLength) {
              CartModel order = cartList[index];
              return _buildCartItem(order);
            }

            if (index == cartLength && index > 0) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total Cost",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "\$${totalCost.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.green[700],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
          separatorBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                height: 1.0,
                color: Colors.grey,
              ),
            );
          },
          itemCount: currentUser.cart.length + 1),
      bottomSheet: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, -1),
              blurRadius: 6.0,
            )
          ],
        ),
        child: TextButton(
          onPressed: () {},
          child: Text(
            "CHECKOUT",
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
