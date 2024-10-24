import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/auth_services.dart';

class SignUpController extends GetxController {
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

  Future<void> signUp() async {
    try {
      log("email =>>>> ${email.value}");
      log("password =>>>> ${password.value}");
      log("confirm password =>>>> ${confirmPassword.value}");
      if (formKey.currentState!.validate()) {
        await authService.signUpWithEmail(
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
