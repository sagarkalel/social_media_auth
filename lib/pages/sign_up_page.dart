import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_auth/controller/sign_up_controller.dart';
import 'package:social_media_auth/widgets/full_screen_loader.dart';

import '../utils/extensions.dart';
import '../widgets/my_input_field.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpController = Get.put(SignUpController());
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Form(
                key: signUpController.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Sign Up",
                          style: Get.textTheme.headlineMedium?.makeBold),
                    ),
                    const Gap(16),
                    MyInputField(
                      hintText: 'Enter email',
                      labelText: "Email",
                      onChanged: signUpController.onEmailChange,
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
                          isMasked: signUpController.isPasswordMasked.value,
                          onChanged: signUpController.onPasswordChange,
                          suffix: IconButton(
                              onPressed: signUpController.togglePasswordMask,
                              icon: Icon(signUpController.isPasswordMasked.value
                                  ? Icons.visibility_off
                                  : Icons.visibility)),
                          validator: (val) {
                            if (val == null || val.length < 6) {
                              return 'Please enter a valid password, and min length should be 6 digit';
                            }
                            return null;
                          },
                        )),
                    const Gap(16),
                    Obx(() => MyInputField(
                          hintText: 'Confirm password',
                          labelText: "Confirm Password",
                          isMasked:
                              signUpController.isConfirmPasswordMasked.value,
                          onChanged: signUpController.onConfirmPasswordChange,
                          suffix: IconButton(
                              onPressed:
                                  signUpController.toggleConfirmPasswordMask,
                              icon: Icon(
                                  signUpController.isConfirmPasswordMasked.value
                                      ? Icons.visibility_off
                                      : Icons.visibility)),
                          validator: (val) {
                            if (val == null) {
                              return 'Please enter a valid password.';
                            } else if (val != signUpController.password.value) {
                              return 'Not matching with above, please check!';
                            }
                            return null;
                          },
                        )),
                    const Gap(kToolbarHeight),
                    SizedBox(
                      width: Get.size.width,
                      child: ElevatedButton(
                        onPressed: signUpController.signUp,
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: const Text("Sign Up"),
                      ),
                    ),
                    const Gap(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                          onPressed: () => Get.offNamed('/loginPage'),
                          child: const Text("Log In"),
                        )
                      ],
                    ),
                    const Gap(kToolbarHeight),
                  ],
                ).padXX16,
              ),
            ),
            Obx(() => FullScreenLoader(signUpController.isLoading.value)),
          ],
        ),
      ),
    );
  }
}
