import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:sim_teacommerce/constants.dart';
import 'package:sim_teacommerce/services/api.dart';
import 'package:sim_teacommerce/services/shared_preferences.dart';

class UserController extends GetxController {
  var accessToken = "".obs;

  @override
  onInit() {
    getFromShared();
    super.onInit();
  }

  Future<void> getFromShared() async {

    print ("getFromShared()");
    var accesstoken = await getAccessToken();
    this.accessToken = accesstoken.obs;

    log("accessToken ${accessToken.toString()}");

    if (accesstoken =="null") {
    log("null accessToken ${accesstoken.toString()}");

      fetchNewToken();
    }
  }

  void fetchNewToken() async {
    try {
      this.accessToken = "".obs;
      var response = await API().fetchdata(baseUrlWithoutHttp, newToken, {"gk":"s"});
      log("fetchNewToken");


      if (response.statusCode == 200) {


        var jsonResponse = json.decode(response.body);
        this.accessToken = jsonResponse.toString().obs;
        setAccessToken(this.accessToken);
      } else {
        Get.snackbar("Error", response.headers["ErrorMessage"].toString());
      }
    } catch (e) {
      Get.snackbar("title", e.toString());
    }
  }
}
