import 'package:flutter/material.dart';
import 'package:social_media_auth/utils/extensions.dart';

class MyInputField extends StatelessWidget {
  const MyInputField({
    super.key,
    required this.hintText,
    required this.labelText,
    this.controller,
    this.onChanged,
    this.suffix,
    this.readOnly = false,
    this.isMasked = false,
    this.validator,
  });

  final String hintText, labelText;
  final TextEditingController? controller;
  final Widget? suffix;
  final bool readOnly;
  final bool isMasked;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText, style: titleStyle),
        const Gap(8),
        TextFormField(
          readOnly: readOnly,
          onChanged: onChanged,
          style: textFieldTextStyle,
          obscureText: isMasked,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            suffixIcon: suffix,
            hintText: hintText,
            hintStyle: readOnly ? textFieldTextStyle : null,
          ),
        ),
      ],
    );
  }
}
