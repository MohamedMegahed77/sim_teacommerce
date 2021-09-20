import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sim_teacommerce/constants.dart';
import 'package:sim_teacommerce/controllers/usercontroller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var lodaing = false;
  var status = false;
  var email = "";
  var password = "";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      // appBar: EmptyAppBar(),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 2,
                  child: Center(
                      child: Text(
                    "Login",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ))),
              Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        padding:
                            EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(kShape)),
                          color: kAccentColor,
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        padding:
                            EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(kShape)),
                          color: kAccentColor,
                        ),
                        child: TextField(
                          controller: emailController,
                          cursorColor: kPrimaryColor,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(Icons.email, color: kPrimaryColor),
                            hintText: "Email address",
                          ),
                        ),
                      ),
                      SizedBox(height: kFixPadding),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        padding:
                            EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(kShape)),
                          color: kAccentColor,
                        ),
                        child: TextField(
                          controller: passwordController,
                          cursorColor: kPrimaryColor,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(Icons.lock, color: kPrimaryColor),
                            hintText: "password",
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(vertical: kDefaultPadding),
                        padding:
                            EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        // ignore: deprecated_member_use
                        child: FlatButton(
                            padding:
                                EdgeInsets.symmetric(vertical: kLessPadding),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(kShape)),
                            color: kPrimaryColor,
                            textColor: kWhiteColor,
                            highlightColor: kTransparent,
                            onPressed: () async => {
                                  if (Get.find<UserController>().isLoading ==
                                      false)
                                    {
                                      this.setState(() {
                                        this.lodaing = true;
                                      }),
                                      await Get.find<UserController>().login(
                                          emailController.text.toString(),
                                          passwordController.text.toString()),
                                      this.setState(() {
                                        this.lodaing = false;
                                      }),
                                    }
                                },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                (Get.find<UserController>().isLoading == false)
                                    ? Text(
                                        "Sign In",
                                        style: TextStyle(fontSize: 18),
                                      )
                                    : SpinKitHourGlass(
                                        size: 25,
                                        color: Colors.white,
                                        duration: Duration(milliseconds: 1500),
                                      ),
                              ],
                            )),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
