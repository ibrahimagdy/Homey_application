import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  final IconData contactIcon;
  final String contactName;

  const ContactItem(
      {super.key, required this.contactIcon, required this.contactName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          contactIcon,
          color: const Color(0xff0096A4),
          size: 18,
        ),
        const SizedBox(width: 3),
        Text(
          contactName,
          style: const TextStyle(color: Color(0xffC6FAFF), fontSize: 13),
        ),
        const SizedBox(width: 3),
      ],
    );
  }
}
