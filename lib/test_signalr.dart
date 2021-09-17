// import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signalr_core/signalr_core.dart';
// import 'package:sim_teacommerce/services/helpers.dart';
// import 'package:sim_teacommerce/services/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TestSignalr extends StatelessWidget {
  const TestSignalr({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    HubConnectionBuilder connection = HubConnectionBuilder();

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text("Start/Stop Signalr"),
          onPressed: () async {
            // FirebaseFirestore.instance
            //     .collection('messages')
            //     .add({'text': 'data added through app'});
            try {
              FirebaseFirestore.instance
                  .collection('Users')
                  .get()
                  .then((QuerySnapshot querySnapshot) {
                querySnapshot.docs.forEach((doc) {
                  print(doc["name"]);
                });
              });

               

              // var snapshots = _fireInstance
              //     .collection('notifications/FtHRFe7sB0djDiabT4dj/messages')
              //     .snapshots();

              // var data = await snapshots.map((elem) {
              //   print("elem${elem.toString()}");
              // });
            } catch (e) {
              print("Error " + e.toString());
            }
            // FirebaseFirestore.instance
            //     .collection('notifications/FtHRFe7sB0djDiabT4dj/messages')
            //     .snapshots()
            //     // ignore: avoid_function_literals_in_foreach_calls
            //     .map((event) => event.docs.forEach((elem) {
            //           print("FireBase Data" + elem["name"].toString());
            //         }));

            // if (await InternetConnectionValidity()) {
            //   Get.snackbar("Start/Stop Signalr", "Test Message");
            //   signalrAction(connection);
            // } else {
            //   showErrorMessage("Internet Connection", "Check The Internet");
            // }
          },
        ),
      ),
    );
  }

  Future<void> signalrAction(connection) async {
    connection = HubConnectionBuilder()
        .withUrl(
            'http://mgahedmohamed49-001-site1.btempurl.com/teahub',
            // 'http://192.168.43.189/tea/teahub',
            HttpConnectionOptions(
              transport: HttpTransportType.webSockets,
              skipNegotiation: true,
              logMessageContent: true,
              logging: (level, message) => print(message),
            ))
        .build();

    await connection.start();

    connection.on('ReceieveMessage', (message) {
      Get.snackbar("ReceieveMessage", message.toString());
    });

    connection.on('update', (message) {
      Get.snackbar("updateMessage", message.toString());
    });

    await connection.invoke('SendMessage');
  }
}
