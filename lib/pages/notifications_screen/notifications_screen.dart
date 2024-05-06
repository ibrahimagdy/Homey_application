import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homey/pages/notifications_screen/widgets/notification_item.dart';

class NotificationScreen extends StatelessWidget {
  static const String routeName = "not";
  final RemoteMessage message;

  const NotificationScreen({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0A1128),
      appBar: AppBar(
        backgroundColor: const Color(0xff0A1128),
        leading: IconButton(
          color: const Color(0xffC6FAFF),
          iconSize: 32,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(CupertinoIcons.back),
        ),
      ),
      body: NotificationItem(message: message),
    );
  }
}