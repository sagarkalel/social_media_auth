import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxMap<String, dynamic> payloadData = RxMap({});

  Future<void> getData() async {
    final data = Get.arguments;
    if (data is RemoteMessage) {
      payloadData.value = data.data;
    } else if (data is NotificationResponse) {
      payloadData.value = jsonDecode(data.payload ?? '');
    }
  }
}
