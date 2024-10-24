import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:social_media_auth/services/common_functions.dart';

class NotificationServices {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// both for ios and android, and this is for background notifications
  static Future<void> initFCM() async {
    try {
      // getting fcm
      getFCM();
      await _firebaseMessaging.requestPermission(
          announcement: true, badge: true, criticalAlert: true);
      final permStatus = await Permission.notification.isGranted;
      if (!permStatus && Get.context != null) {
        // TODO: handle when permission denied, like show dialog or snackbar
        Get.snackbar("Alert",
            "We are not able to send you notification, since you have declined notification permission!");
        return;
      }
    } catch (e) {
      log("Error while initializing FCM");
    }
  }

  /// get and listen FCM
  static Future<void> getFCM() async {
    final token = await _firebaseMessaging.getToken();
    log("firebase messaging token: $token upToHere");
    // added listen method on token refresh to
    _firebaseMessaging.onTokenRefresh.listen((event) {
      log("FCM token has been refreshed $event");
      // we can update this updated token in our db
    });
  }

  static Future<void> initLocalNotifications() async {
    try {
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings("@mipmap/ic_launcher");

      /// belows part is for ios
      final DarwinInitializationSettings darwinInitializationSettingsIos =
          DarwinInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) {},
        notificationCategories: [
          // DarwinNotificationCategory(
          //   'demoCategory',
          //   actions: <DarwinNotificationAction>[
          //     DarwinNotificationAction.plain('id_1', 'Action 1'),
          //     DarwinNotificationAction.plain('id_2', 'Action 2',
          //         options: <DarwinNotificationActionOption>{
          //           DarwinNotificationActionOption.destructive
          //         }),
          //     DarwinNotificationAction.plain('id_3', 'Action 3',
          //         options: <DarwinNotificationActionOption>{
          //           DarwinNotificationActionOption.foreground
          //         }),
          //   ],
          //   options: <DarwinNotificationCategoryOption>{
          //     DarwinNotificationCategoryOption.hiddenPreviewShowTitle
          //   },
          // )
        ],
      );

      final InitializationSettings initializationSettings =
          InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: darwinInitializationSettingsIos,
        // we can add here for linux and macos, for now i am skipping
      );

      /// requesting platform specific permissions if earlier not allowed when asked while initializing FCM
      if (Platform.isAndroid) {
        _requestNotificationPermissionForAndroid();
      } else if (Platform.isIOS) {
        _requestNotificationPermissionForIOS();
      }

      await _flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: onNotificationTap,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap,
      );
    } catch (e) {
      log("Error while initializing Local Notifications");
    }
  }

  /// request permission function for IOS
  static Future<bool> _requestNotificationPermissionForIOS() async {
    final bool? result = await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
    return result ?? false;
  }

  /// request permission function for android
  static Future<bool> _requestNotificationPermissionForAndroid() async {
    // requesting notification permission for android 13 and above
    final bool? result = await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    return result ?? false;
  }

  /// on tap local notifications
  static Future<void> onNotificationTap(NotificationResponse resp) async {
    // Get.toNamed("/displayPayloadScreen", arguments: resp);
    final targetScreen = CommonFunctions.goToRespectiveScreen(resp);
    if (targetScreen == null) return;
    await Get.to(() => targetScreen);
  }

  /// handling of notifications in terminated state
  static Future<void> listenAndActionOnTermStateNotifications() async {
    // delay should be more that splash screen, because until then user reaches to home screen
    // so user can come back to home screen from respective reached screen after tapping on notification
    await Future.delayed(3.seconds);
    // for handling on tap in terminated state
    final msgData = await _firebaseMessaging.getInitialMessage();
    if (msgData == null) return;
    // await Get.toNamed("/displayPayloadScreen", arguments: msgData);
    final targetScreen = CommonFunctions.goToRespectiveScreen(msgData);
    if (targetScreen == null) return;
    await Get.to(() => targetScreen);
  }

  /// listen to background notifications
  static Future<void> listenBackgroundNotifications() async {
    // FirebaseMessaging.onBackgroundMessage((message) async {
    //   log("notification received in background: ${message.notification?.title}");
    //   if (message.notification != null) return;
    //   // TODO: do something here
    // });
  }

  /// listen to foreground notifications
  static Future<void> listenForegroundNotifications() async {
    try {
      FirebaseMessaging.onMessage.listen((message) async {
        log("notification received in foreground: ${message.notification?.title}");
        if (message.notification == null) return;
        await showSimpleNotification(
          title: message.notification?.title ?? '',
          body: message.notification?.body ?? '',
          payload: jsonEncode(message.data),
        );
      });
    } catch (e) {
      log("Error: $e");
    }
  }

  /// on tap of background notification
  static Future<void> onBackgroundNotificationTap() async {
    try {
      FirebaseMessaging.onMessageOpenedApp.listen((event) async {
        if (event.notification == null) return;
        log("Background notification tapped: ${event.notification?.title}");
        // Get.toNamed('/displayPayloadScreen', arguments: event);
        final targetScreen = CommonFunctions.goToRespectiveScreen(event);
        if (targetScreen == null) return;
        await Get.to(targetScreen);
      });
    } catch (e) {
      log("Error: $e");
    }
  }

  /// show simple notification
  static Future<void> showSimpleNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidNotificationDetails = AndroidNotificationDetails(
      'my channelId',
      'my channelName',
      ticker: 'ticker',
      priority: Priority.high,
      importance: Importance.max,
      // actions: <AndroidNotificationAction>[
      //   AndroidNotificationAction('id_1', 'Action 1'),
      //   AndroidNotificationAction('id_2', 'Action 2'),
      //   AndroidNotificationAction('id_3', 'Action 3'),
      // ],
    );
    const darwinNotificationDetails = DarwinNotificationDetails();
    const notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }
}
