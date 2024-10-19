import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_auth/pages/home_page.dart';
import 'package:social_media_auth/pages/sign_up_page.dart';

import 'pages/login_page.dart';
import 'pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        darkTheme: ThemeData.dark(useMaterial3: true),
        themeMode: ThemeMode.dark,
        routes: {
          "/": (ctx) => const SplashScreen(),
          "/loginPage": (ctx) => const LoginPage(),
          "/signUpPage": (ctx) => const SignUpPage(),
          "/homePage": (ctx) => const HomePage(),
        },
      ),
    );
  }
}
