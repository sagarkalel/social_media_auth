import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_auth/utils/extensions.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader(this.visible, {super.key}) : super();

  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ModalBarrier(color: Get.theme.primaryColor.withOpacity(0.5)),
          const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              Gap(16),
              Text("Loading ..."),
            ],
          ),
        ],
      ),
    );
  }
}
