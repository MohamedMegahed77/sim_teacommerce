import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class API extends GetConnect {
  Future<dynamic> getApi(baseUrl, url) async {
    final response = await get('$baseUrl/$url');

    if (response.status.isOk) {
      return response;
    } else {
      Get.snackbar("Error", response.statusText!);
      return Future.error(response.statusText!);
    }
  }

  Future<dynamic> fetchdata(baseUrl, burl, headers) async {
    final url = Uri.http('$baseUrl', '$burl');

    print("fetchdata url ()" + url.toString());

    final response = await http.get(url, headers: headers);
    print("fetchdata response ()" + response.body.toString());

    if (response.statusCode == 200) {
      return response;
    } else {
      Get.snackbar("Error", response.headers["ErrorMessage"].toString());
      return Future.error(response.statusCode);
    }
  }

  Future<dynamic> fetchdatawithParams(baseUrl, burl, headers, qps) async {
    final url = Uri.http('$baseUrl', '$burl', qps);

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return response;
    } else {
      Get.snackbar("Error", response.headers["ErrorMessage"].toString());
      return Future.error(response.statusCode);
    }
  }

  Future<dynamic> postData(baseUrl, burl, headers, body) async {
    try {
      final url = Uri.http('$baseUrl', '$burl');

      print("url ()" + url.toString());

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      return "Error";
    }
  }
}
