import 'package:get/get.dart';

class LoginController extends GetxController {
  final isPasswordMasked = true.obs;
  final isConfirmPasswordMasked = true.obs;

  void togglePasswordMask() {
    isPasswordMasked.value = !isPasswordMasked.value;
  }

  void toggleConfirmPasswordMask() {
    isConfirmPasswordMasked.value = !isConfirmPasswordMasked.value;
  }
}
