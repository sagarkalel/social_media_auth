import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:social_media_auth/pages/display_payload_screen.dart';

class CommonFunctions {
  static Widget? _respectiveWidgetFromScreen(
      Map<String, dynamic> data, String? img) {
    final screen = data['screenName'] as String?;
    switch (screen) {
      case "displayPayloadScreen":
        return DisplayPayloadScreen(
          id: int.tryParse(data['id']),
          name: data['name'],
          phoneNumber: data['phoneNumber'],
        );
      case "displayMessage1":
        return DisplayMessage1(
          id: int.tryParse(data['id']),
          name: data['name'],
          phoneNumber: data['phoneNumber'],
        );
      case "displayMessage2":
        return DisplayMessage2(
          id: int.tryParse(data['id'] ?? ''),
          name: data['name'],
          phoneNumber: data['phoneNumber'],
          initialIndexParent: int.tryParse(data['initialIndexParent'] ?? ''),
          initialIndexChild: int.tryParse(data['initialIndexChild'] ?? ''),
        );
      case "displayMessage3":
        return DisplayMessage3(
          id: int.tryParse(data['id']),
          name: data['name'],
          phoneNumber: data['phoneNumber'],
          img: img,
        );
      default:
        return null;
    }
  }

  static Widget? goToRespectiveScreen(details) {
    switch (details.runtimeType) {
      case RemoteMessage:
        final String? img = details.notification?.android?.imageUrl;
        return _respectiveWidgetFromScreen(details.data, img);
      case NotificationResponse:
        final data = jsonDecode(details.payload ?? '');
        return _respectiveWidgetFromScreen(data, null);
      default:
        return null;
    }
  }
}
