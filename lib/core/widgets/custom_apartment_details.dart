import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomApartmentDetails extends StatelessWidget {
  final String imageIcon;
  final String property;
  final dynamic info;

  const CustomApartmentDetails({
    super.key,
    required this.imageIcon,
    required this.property,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            Image.asset(imageIcon),
            const SizedBox(width: 10),
            Expanded(child: Text(property)),
            SizedBox(width: mediaQuery.width * 0.15),
            Expanded(
              child: Text(
                info,
                style: const TextStyle(color: Color(0xff0096A4)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}
