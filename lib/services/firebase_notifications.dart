import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

late FirebaseMessaging _messaging;

void registerNotification() async {
  await Firebase.initializeApp();
  _messaging = FirebaseMessaging.instance;

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

 
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  print("Handling a background message: ${message.messageId}");
  Get.snackbar("Handling a background message", message.messageId.toString());
}
