import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:sim_teacommerce/controllers/usercontroller.dart';
import 'package:sim_teacommerce/models/category.dart';
import 'package:sim_teacommerce/models/product.dart';
import 'package:sim_teacommerce/screens/screens.dart';
import 'package:sim_teacommerce/services/api.dart';
import 'package:sim_teacommerce/widgets/best_products.dart';
import 'package:sim_teacommerce/widgets/widgets.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Category> categories = [];
  List<Product> products = [];

  var isLoagin = false;
  var isLoadmoreProudcts = false;
  int productPageSize = 20;
  int productPageindex = 1;

  @override
  void initState() {
    super.initState();
    getHomepage();
  }

  Future<void> getHomepage() async {
    try {
      this.setState(() {
        this.isLoagin = true;
      });

      var response =
          await API().fetchdata(baseUrlWithoutHttp, homepageUrl, {"gk": "k"});

      if (response.statusCode == 200) {
        var productsjson = json.decode(response.body);

        List products = productsjson["products"];
        List categories = productsjson["categories"];

        var allProductsList =
            products.map((element) => Product.fromJson(element)).toList();

        var allcategories =
            categories.map((element) => Category.fromJson(element)).toList();

        this.setState(() {
          this.products = allProductsList;
          this.categories = allcategories;
        });
      } else {
        Get.snackbar("Error", response.headers["ErrorMessage"].toString());
      }
    } catch (e) {
      Get.snackbar("title", e.toString());
    } finally {
      this.setState(() {
        this.isLoagin = false;
      });
    }
  }

  Future<void> loadMoreProducts() async {
    try {
      this.setState(() {
        this.isLoadmoreProudcts = true;
      });

      var params = {"index": productPageindex.toString(), "pagesize": "30"};

      var response = await API().fetchdatawithParams(
          baseUrlWithoutHttp, '$moreproductsUrl', {"gk": "k"}, params);

      if (response.statusCode == 200) {
        List products = json.decode(response.body);

        var allProductsList =
            products.map((element) => Product.fromJson(element)).toList();

        this.setState(() {
          this.products.addAll(allProductsList);

          this.productPageindex += 1;
        });
      } else {
        Get.snackbar("Error", response.headers["ErrorMessage"].toString());
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      this.setState(() {
        this.isLoadmoreProudcts = false;
      });
    }
  }

  Future<List<Product>> searchProducts(String search) async {
    List<Product> searchProducts = [];

    if (search == "") {
      return searchProducts;
    }
    try {
      var headers = <String, String>{
        'Content-Type': 'application/json',
      };

      var body = jsonEncode(search);

      print("body () => ${body.toString()}");

      var response = await API()
          .postData(baseUrlWithoutHttp, searchProductsUrl, headers, body);

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("ECommerce App ", style: TextStyle(fontSize: 20)),
            leading: IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await Get.find<UserController>().clearSharedPreferences();
                // await getHomepage();
                // this.setState(() {
                //   this.isLoagin = false;
                //   this.productPageindex = 1;
                // });
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
              this.setState(() {
                this.isLoagin = true;
              });
              await getHomepage();
              this.setState(() {
                this.isLoagin = false;
              });
            },
            child: (this.isLoagin == true)
                ? Center(
                    child: SpinKitHourGlass(
                    size: 35,
                    color: Colors.green,
                    duration: Duration(milliseconds: 1500),
                  ))
                : LazyLoadScrollView(
                    isLoading: this.isLoadmoreProudcts,
                    onEndOfPage: () => loadMoreProducts(),
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TypeAheadField(
                              textFieldConfiguration:
                                  const TextFieldConfiguration(
                                      autofocus: false,
                                      style: TextStyle(fontSize: 16),
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder())),
                              suggestionsCallback: (pattern) async {
                                return await searchProducts(pattern);
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
                              },
                            )),
                        CategoriesListView(categories: this.categories),
                        ProductsListView(products: this.products),
                      ],
                    ),
                  ),
          ),
        ));
  }
}
