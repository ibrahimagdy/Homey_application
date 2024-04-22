import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 1,
      color: const Color(0xff0096A4).withOpacity(0.26),
      endIndent: 25,
      indent: 25,
    );
  }
}
