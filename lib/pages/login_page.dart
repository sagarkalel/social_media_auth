import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_auth/controller/login_controller.dart';
import 'package:social_media_auth/utils/extensions.dart';
import 'package:social_media_auth/widgets/full_screen_loader.dart';
import 'package:social_media_auth/widgets/my_input_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Form(
                key: loginController.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Log In",
                          style: Get.textTheme.headlineMedium?.makeBold),
                    ),
                    const Gap(16),
                    MyInputField(
                      hintText: 'Enter email',
                      labelText: "Email",
                      onChanged: loginController.onEmailChange,
                      validator: (val) {
                        if (val == null || val.length < 3) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const Gap(16),
                    Obx(() => MyInputField(
                          hintText: 'Enter password',
                          labelText: "Password",
                          isMasked: loginController.isPasswordMasked.value,
                          onChanged: loginController.onPasswordChange,
                          suffix: IconButton(
                              onPressed: loginController.togglePasswordMask,
                              icon: Icon(loginController.isPasswordMasked.value
                                  ? Icons.visibility_off
                                  : Icons.visibility)),
                          validator: (val) {
                            if (val == null || val.length < 6) {
                              return 'Please enter a valid password!';
                            }
                            return null;
                          },
                        )),
                    const Gap(kToolbarHeight),
                    SizedBox(
                      width: Get.size.width,
                      child: ElevatedButton(
                        onPressed: loginController.login,
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
                          child: const Text("Sing Up"),
                        )
                      ],
                    ),
                    const Gap(kToolbarHeight),
                  ],
                ).padXX16,
              ),
            ),
            Obx(() => FullScreenLoader(loginController.isLoading.value)),
          ],
        ),
      ),
    );
  }
}
