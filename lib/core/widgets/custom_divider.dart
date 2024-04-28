import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double? thickness;
  final Color? color;

  const CustomDivider({super.key, this.thickness, this.color});

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
