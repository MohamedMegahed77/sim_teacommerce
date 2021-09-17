import 'package:shared_preferences/shared_preferences.dart';

Future<String> getAccessToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString('accessToken');
  return accessToken == "" ? "" : accessToken.toString();
}

Future<void> clearAccessToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("accessToken");
}

void setAccessToken(token) async {
  print("setAccessToken () => $token ");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("accessToken", "$token");
}
