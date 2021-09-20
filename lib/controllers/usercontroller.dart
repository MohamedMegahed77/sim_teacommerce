import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sim_teacommerce/constants.dart';
import 'package:sim_teacommerce/models/auth/user.dart';
import 'package:sim_teacommerce/services/api.dart';
import 'package:sim_teacommerce/splash_screen.dart';
import 'package:sim_teacommerce/wrapper.dart';

class UserController extends GetxController {
  var isLogged = false.obs;
  var isLoading = false.obs;
  late Rx<User> user;

  @override
  onInit() {
    getUserFromSharedPreference();
    super.onInit();
  }

  Future<void> getUserFromSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var token = prefs.getString('token');
    this.isLogged = (token == "" || token == null ? false.obs : true.obs);

    if (this.isLogged == false.obs) return;

    var userName = prefs.getString('userName');
    var userId = prefs.getInt('userId');
    var name = prefs.getString('name');
    var imgUrl = prefs.getString('imgUrl');

    this.user = User(
            token: token!,
            tokenExpireTime: DateTime.now(),
            userName: userName!,
            userId: userId!,
            name: name!,
            imgUrl: imgUrl!)
        .obs;
  }

  Future<void> clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    prefs.remove("userName");
    prefs.remove("userId");
    prefs.remove("imgUrl");
    prefs.remove("name");
    prefs.remove("tokenExpireTime");

    var token = prefs.getString('token');
    this.isLogged = false.obs;

    Get.off(SplashScreen());
  }

  void saveUsertoSharedPreferences(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", user.token);
    await prefs.setString("userName", user.userName);
    await prefs.setInt("userId", user.userId);
    await prefs.setString("imgUrl", user.imgUrl);
    await prefs.setString("name", user.name);
    await prefs.setString("tokenExpireTime", user.tokenExpireTime.toString());
    this.isLogged = true.obs;

    Get.off(SplashScreen());
  }

  Future<void> login(String username, String password) async {
    try {
      this.isLoading = true.obs;
      var headers = <String, String>{'Content-Type': 'application/json'};

      var body = jsonEncode(
          <String, String>{"username": username, "password": password});

      var response =
          await API().postData(baseUrlWithoutHttp, loginUrl, headers, body);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body.toString());
        var user = User.fromJson(jsonResponse);

        this.isLogged = false.obs;
        this.user = user.obs;

        this.isLoading = false.obs;
        saveUsertoSharedPreferences(user);
      } else {
        Get.rawSnackbar(
            title: "Login",
            message: "Enter Valid Email and Password",
            backgroundColor: Colors.red);
      }
    } catch (e) {} finally {
      this.isLoading = false.obs;
    }
  }
}
