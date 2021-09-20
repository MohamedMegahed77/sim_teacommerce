import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sim_teacommerce/controllers/usercontroller.dart';
import 'package:sim_teacommerce/screens/auth/login.dart';
import 'package:sim_teacommerce/screens/home_screen.dart';
import 'package:sim_teacommerce/test_signalr.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => Get.find<UserController>().isLogged == true
            ? HomeScreen()
            : LoginScreen()));
  }
}
