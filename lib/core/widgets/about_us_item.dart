import 'package:flutter/material.dart';

import 'custom_divider.dart';

class AboutUsItem extends StatelessWidget {
  final String aboutUsImage;
  final String headTitle;
  final String desc;

  const AboutUsItem(
      {super.key,
      required this.aboutUsImage,
      required this.headTitle,
      required this.desc});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: mediaQuery.height * 0.03,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.asset(
            aboutUsImage,
          ),
        ),
        SizedBox(
          height: mediaQuery.height * 0.02,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Text(
            headTitle,
            style: const TextStyle(
              color: Color(0xffC6FAFF),
              fontSize: 23,
            ),
          ),
        ),
        const CustomDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Text(
            desc,
            style: const TextStyle(
              color: Color(0xff0096A4),
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
