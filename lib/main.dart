import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sim_teacommerce/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // ignore: avoid_print
  print("Handling a background message: ${message.messageId}");
  Get.snackbar("Handling a background message", message.messageId.toString());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Get.snackbar("Firebase Notification ", message.messageId.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ECommerce ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[50],
        primaryColor: Colors.deepOrangeAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(),
    );
  }
}
 



// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   FlutterBackgroundService.initialize(onStart);

//   runApp(MyApp());
// }

// void onStart() {
//   WidgetsFlutterBinding.ensureInitialized();
//   final service = FlutterBackgroundService();

//   service.onDataReceived.listen((event) {
//     if (event!["action"] == "setAsForeground") {
//       service.setForegroundMode(true);
//       return;
//     }

//     if (event["action"] == "setAsBackground") {
//       service.setForegroundMode(false);
//     }

//     if (event["action"] == "stopService") {
//       service.stopBackgroundService();
//     }
//   });

//   // bring to foreground
//   service.setForegroundMode(true);
  
//   Timer.periodic(const Duration(seconds: 1), (timer) async {
//     if (!(await service.isServiceRunning())) timer.cancel();
//     service.setNotificationInfo(
//       title: "My App Service",
//       content: "Updated at ${DateTime.now()}",
//     );


// service.setNotificationInfo(
//       title: "My App Service",
//       content: "Updated at ${DateTime.now()}",
//     );
//     service.sendData(
//       {"current_date": DateTime.now().toIso8601String()},
//     );
//   });
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   String text = "Stop Service";
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Service App'),
//         ),
//         body: Column(
//           children: [
//             StreamBuilder<Map<String, dynamic>?>(
//               stream: FlutterBackgroundService().onDataReceived,
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }

//                 final data = snapshot.data!;
//                 DateTime? date = DateTime.tryParse(data["current_date"]);
//                 return Text(date.toString());
//               },
//             ),
//             ElevatedButton(
//               child: const Text("Foreground Mode"),
//               onPressed: () {
//                 FlutterBackgroundService()
//                     .sendData({"action": "setAsForeground"});
//               },
//             ),
//             ElevatedButton(
//               child: const Text("Background Mode"),
//               onPressed: () {
//                 FlutterBackgroundService()
//                     .sendData({"action": "setAsBackground"});
//               },
//             ),
//             ElevatedButton(
//               child: Text(text),
//               onPressed: () async {
//                 var isRunning =
//                     await FlutterBackgroundService().isServiceRunning();
//                 if (isRunning) {
//                   FlutterBackgroundService().sendData(
//                     {"action": "stopService"},
//                   );
//                 } else {
//                   FlutterBackgroundService.initialize(onStart);
//                 }
//                 if (!isRunning) {
//                   text = 'Stop Service';
//                 } else {
//                   text = 'Start Service';
//                 }
//                 setState(() {});
//               },
//             ),
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             FlutterBackgroundService().sendData({
//               "hello": "world",
//             });
//           },
//           child: const Icon(Icons.play_arrow),
//         ),
//       ),
//     );
//   }
// }
