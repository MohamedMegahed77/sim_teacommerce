import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:sim_teacommerce/constants.dart';
import 'package:sim_teacommerce/models/product.dart';
import 'package:sim_teacommerce/services/api.dart';

import 'user_controller.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var isAddLoading = false.obs;

  late Product productDetails;

  var allProductsList = List<Product>.empty(growable: true).obs;
  var bestproductsList = List<Product>.empty(growable: true).obs;

  @override
  void onInit() {
    fetchAllProducts();

    fetchBestProducts();
    super.onInit();
  }

  void getchBestProducts() async {
    log("fetchBestProducts");

    try {
      var response = await API().getApi(baseUrl, bestProducts);

      List<Product> items = productFromJson(response.body);
      bestproductsList.assignAll(items);
    } finally {
      isLoading(false);
    }
  }

  void fetchAllProducts() async {
    try {
      log("allProductsList ()");

      var response =
          await API().fetchdata(baseUrlWithoutHttp, allProducts, {"gk": "k"});
      log("allProductsList () ${response.statusCode.toString()}");

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        allProductsList = jsonResponse
            .map((element) => Product.fromJson(element))
            .toList()
            .obs;
        log("allProductsList ()  allProductsList ${allProductsList.length.toString()}");
      } else {
        Get.snackbar("Error", response.headers["ErrorMessage"].toString());
      }
    } catch (e) {
      Get.snackbar("title", e.toString());
    }
  }

  void fetchBestProducts() async {
    try {
      var response =
          await API().fetchdata(baseUrlWithoutHttp, bestProducts, {"gk": "k"});
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        bestproductsList = jsonResponse
            .map((element) => Product.fromJson(element))
            .toList()
            .obs;
      } else {
        Get.snackbar("Error", response.headers["ErrorMessage"].toString());
      }
    } catch (e) {
      Get.snackbar("title", e.toString());
    }
  }

  void fetchProductDetails(id) async {
    log("fetchProductDetails");

    try {
      var accessToken = Get.find<UserController>().accessToken.toString();
      var params = {"ID": id.toString()};

      var response = await API().fetchdatawithParams(baseUrlWithoutHttp,
          '$productsDetails', {'accessToken': accessToken}, params);

      if (response.statusCode == 200) {
        productDetails =
            json.decode(response.body).map((x) => Product.fromJson(x)).obs;
      }
    } catch (e) {
      print("Bad Request Error Message");
      e.printError();
      Get.snackbar("title", e.toString());
    }
  }

  Future<List<Product>> searchProducts(String search) async {
    List<Product> searchProducts = [];

    if(search=="")
    {
      return searchProducts;
    }    
    try {

      var headers = <String, String>{
        'Content-Type': 'application/json',
      };
      
      var body = jsonEncode(search);

      var response =await API().postData(baseUrlWithoutHttp, searchProductsUrl, headers, body);


      
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        searchProducts =
            jsonResponse.map((element) => Product.fromJson(element)).toList();
      } else {
        Get.snackbar("Error", response.headers["ErrorMessage"].toString());
      }
    } catch (e) {
      Get.snackbar("Search", e.toString());
    }

    return searchProducts;
  }
}
