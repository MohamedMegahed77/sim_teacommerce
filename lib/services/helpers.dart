import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> InternetConnectionValidity() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if(connectivityResult ==ConnectivityResult.none)
  {
      return false;
  }

   return true;
}



showErrorMessage(title ,message)
{
  Get.changeTheme(Get.isDarkMode?ThemeData.light():ThemeData.dark());
Get.rawSnackbar(title: title,message: message,backgroundColor: Colors.red);  

// Get.snackbar(title, message,colorText: Colors.white,backgroundColor: Colors.red[400]);      
}
