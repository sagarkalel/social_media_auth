import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_auth/firebase_options.dart';
import 'package:social_media_auth/pages/display_payload_screen.dart';
import 'package:social_media_auth/pages/home_page.dart';
import 'package:social_media_auth/pages/sign_up_page.dart';
import 'package:social_media_auth/services/notification_services.dart';

import 'pages/login_page.dart';
import 'pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // initialize firebase messaging
  NotificationServices.initFCM();

  // initialize local notifications
  NotificationServices.initLocalNotifications();

  // listen background notifications
  NotificationServices.listenBackgroundNotifications();

  // handling notifications when opened from terminated state
  NotificationServices.listenAndActionOnTermStateNotifications();

  // listen foreground notifications
  NotificationServices.listenForegroundNotifications();

  // on tapped on background notification
  NotificationServices.onBackgroundNotificationTap();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(useMaterial3: true),
        themeMode: ThemeMode.dark,
        routes: {
          "/": (ctx) => const SplashScreen(),
          "/loginPage": (ctx) => const LoginPage(),
          "/signUpPage": (ctx) => const SignUpPage(),
          "/homePage": (ctx) => const HomePage(),
          "/displayPayloadScreen": (ctx) => const DisplayPayloadScreen(),
          "/displayMessage1": (ctx) => const DisplayMessage1(),
          "/displayMessage2": (ctx) => const DisplayMessage2(),
          "/displayMessage3": (ctx) => const DisplayMessage3(),
        },
      ),
    );
  }
}
