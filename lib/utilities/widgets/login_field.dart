import 'package:bisleriumbloggers/utilities/helpers/app_colors.dart';
import 'package:flutter/material.dart';

class LoginField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keywordtype;
  final bool obscureText;

  const LoginField({
    super.key,
    required this.hintText,
    required this.controller,
    this.keywordtype,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 400,
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keywordtype,
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(27),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Bislerium.borderColor,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Bislerium.gradient2,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Bislerium.whiteColor.withOpacity(0.4)),
        ),
        style: const TextStyle(color: Bislerium.whiteColor),
      ),
    );
  }
}
