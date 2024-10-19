import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_auth/controller/login_controller.dart';
import 'package:social_media_auth/utils/extensions.dart';
import 'package:social_media_auth/widgets/my_input_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login", style: Get.textTheme.headlineMedium?.makeBold),
              const Gap(16),
              MyInputField(
                hintText: 'Enter email',
                labelText: "Email",
              ),
              const Gap(16),
              Obx(() => MyInputField(
                    hintText: 'Enter password',
                    labelText: "Password",
                    isMasked: loginController.isPasswordMasked.value,
                    suffix: IconButton(
                        onPressed: loginController.togglePasswordMask,
                        icon: Icon(loginController.isPasswordMasked.value
                            ? Icons.visibility_off
                            : Icons.visibility)),
                  )),
              const Gap(16),
              Obx(() => MyInputField(
                    hintText: 'Confirm password',
                    labelText: "Confirm Password",
                    isMasked: loginController.isConfirmPasswordMasked.value,
                    suffix: IconButton(
                        onPressed: loginController.toggleConfirmPasswordMask,
                        icon: Icon(loginController.isConfirmPasswordMasked.value
                            ? Icons.visibility_off
                            : Icons.visibility)),
                  )),
              const Gap(kToolbarHeight),
              SizedBox(
                width: Get.size.width,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text("Login"),
                ),
              ),
              const Gap(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () => Get.offNamed('/signUpPage'),
                    child: const Text("Sing In"),
                  )
                ],
              ),
              const Gap(kToolbarHeight),
            ],
          ).padXX16,
        ),
      ),
    );
  }
}
