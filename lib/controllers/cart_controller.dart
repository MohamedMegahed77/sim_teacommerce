import 'dart:convert';

import 'package:get/get.dart';
import 'package:sim_teacommerce/models/cart.dart';
import 'package:sim_teacommerce/services/api.dart';

import '../constants.dart';
import 'user_controller.dart';

class CartController extends GetxController {
  static Future<void> sendTest() async {
    try {
      var accessToken = Get.find<UserController>().accessToken.toString();

      var headers = {
        "accessToken": accessToken,
        'Content-Type': 'application/json; charset=UTF-8',
      };
      int Qty = 2;
      int ProductID = 1;

      var body = {"ProductID": ProductID, "Qty": Qty};

      var response = await API()
          .postData(baseUrlWithoutHttp, testUrl, headers, {"Test": "Test"});

      if (response.statusCode == 200) {
        // print("response.body" + response.body.toString());
      }
    } catch (e) {
      // print("Bad Request Error Message");
      e.printError();
      Get.snackbar("title", e.toString());
    }
  }

  Future<int> adtoCart(int ProductID, int Qty) async {
    try {
      print("adtoCart()  => start ");

      var accessToken = Get.find<UserController>().accessToken.toString();
      var headers = <String, String>{
        "accessToken": accessToken,
        'Content-Type': 'application/json; charset=UTF-8',
      };

      var body = jsonEncode(<String, int>{"ProductID": ProductID, "Qty": Qty});
      var response =
          await API().postData(baseUrlWithoutHttp, addtoCart, headers, body);

      print("addtoCart.statusCode ()" + response.statusCode.toString());
      print("addtoCart.body ()" + response.body.toString());

      int statusCode = response.statusCode;
      return statusCode;
    } catch (e) {
      return 400;
    }
  }

  Future<int> updateProductCart(int ProductID, int Qty) async {
    try {
      print("updateProductCart()  => start ");

      var accessToken = Get.find<UserController>().accessToken.toString();
      var headers = <String, String>{
        "accessToken": accessToken,
        'Content-Type': 'application/json; charset=UTF-8',
      };

      var body = jsonEncode(<String, int>{"ProductID": ProductID, "Qty": Qty});
      var response = await API()
          .postData(baseUrlWithoutHttp, updateProductCartUrl, headers, body);

      print("updateProductCart.statusCode ()" + response.statusCode.toString());
      print("updateProductCart.body ()" + response.body.toString());

      int statusCode = response.statusCode;
      return statusCode;
    } catch (e) {
      return 400;
    }
  }

  Future<List<CartModel>> fetchCartList() async {
    List<CartModel> cartList = [];

    try {
      // print("fetchCart ()");
      var accessToken = Get.find<UserController>().accessToken.toString();
      var headers = <String, String>{
        "accessToken": accessToken,
        'Content-Type': 'application/json; charset=UTF-8',
      };

      var response =
          await API().fetchdata(baseUrlWithoutHttp, cartAll, headers);

      // print("fetchCartList () ${response.statusCode.toString()}");

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        cartList =
            jsonResponse.map((element) => CartModel.fromJson(element)).toList();

        // print("cartList ()  cartList ${cartList.length.toString()}");
      } else {
        Get.snackbar("Error", response.headers["ErrorMessage"].toString());
      }
    } catch (e) {
      Get.snackbar("title", e.toString());
    }

    return cartList;
  }
}
