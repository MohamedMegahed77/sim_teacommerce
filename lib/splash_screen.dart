import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sim_teacommerce/controllers/usercontroller.dart';
import 'package:sim_teacommerce/test_signalr.dart';
import 'package:sim_teacommerce/wrapper.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserController _user = Get.put(UserController());

    Future.delayed(const Duration(seconds: 3), () {
      Get.off(Wrapper(),
          transition: Transition.rightToLeftWithFade,
          duration: const Duration(milliseconds: 780));
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.lightBlue, Colors.lightGreen])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SpinKitHourGlass(
              color: Colors.white,
              duration: Duration(milliseconds: 1500),
            ),
            SizedBox(height: 10),
            Text("Preparing",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17))
          ],
        ),
      ),
    );
  }
}
