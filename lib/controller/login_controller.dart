import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:social_media_auth/services/auth_services.dart';

class LoginController extends GetxController {
  final authService = AuthServices();
  final isPasswordMasked = true.obs;
  final isConfirmPasswordMasked = true.obs;
  final formKey = GlobalKey<FormState>();
  final email = ''.obs;
  final password = ''.obs;
  final confirmPassword = ''.obs;
  final RxBool isLoading = RxBool(false);

  void togglePasswordMask() {
    isPasswordMasked.value = !isPasswordMasked.value;
  }

  void toggleConfirmPasswordMask() {
    isConfirmPasswordMasked.value = !isConfirmPasswordMasked.value;
  }

  void onEmailChange(String val) => email.value = val;

  void onPasswordChange(String val) => password.value = val;

  void onConfirmPasswordChange(String val) => confirmPassword.value = val;

  Future<void> login() async {
    try {
      isLoading.value = true;
      log("email =>>>> ${email.value}");
      log("password =>>>> ${password.value}");
      log("confirm password =>>>> ${confirmPassword.value}");
      if (formKey.currentState?.validate() == true) {
        await authService.loginWithEmail(
            email.value.toLowerCase(), password.value);
        Get.offAllNamed('/homePage');
        isLoading.value = false;
      }
      isLoading.value = false;
    } catch (e) {
      log("Something went wrong: $e");
      isLoading.value = false;
      Get.snackbar('Alert!', "Something went wrong, please try again! $e");
    }
  }
}
