import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final bool obscureText;
  final Color color;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  final TextStyle style;
  final TextStyle inputStyle;

  const CustomTextFormField(
      {super.key,
      this.hintText,
      this.obscureText = false,
      required this.controller,
      this.validator,
      this.suffixIcon,
      this.color = Colors.white,
      required this.style,
      required this.inputStyle});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: inputStyle,
      enableSuggestions: true,
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(15),
          hintText: hintText,
          hintStyle: style,
          fillColor: color,
        filled: true,
        suffixIcon: suffixIcon,
        suffixIconConstraints: const BoxConstraints(maxWidth: 50),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xffACACAC),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
