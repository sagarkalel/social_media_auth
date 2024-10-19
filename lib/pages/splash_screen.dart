import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_auth/utils/extensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await Future.delayed(2.second);
        Get.offNamed('/loginPage');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Loading...", style: titleStyle),
            const Gap(16),
            const LinearProgressIndicator(),
          ],
        ).padXX16,
      ),
    );
  }
}
