import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:homey/core/caching/hive_manger.dart';
import 'package:homey/pages/notifications_screen/models/notification_model.dart';
import 'package:overlay_support/overlay_support.dart';

class NotificationScreen extends StatefulWidget {
  static const String routeName = "not";

  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late final FirebaseMessaging messaging;
  List<NotificationModel> notifications = [];

  void registerNotification() async {
    await Firebase.initializeApp();
    messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted permission");
    } else {
      print("Permission declined by users");
    }

    String? token = await FirebaseMessaging.instance.getToken();
    print('FCM Token: $token');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      NotificationModel notification = NotificationModel(
        title: message.notification!.title,
        body: message.notification!.body,
        dataTitle: message.data['title'],
        dataBody: message.data['body'],
      );
      setState(() {
        HiveManager.getInstance().cacheData(notification);
        notifications.add(notification);
      });
      if (notification != null) {
        showSimpleNotification(
          elevation: 0,
          contentPadding: const EdgeInsets.all(20),
          Text(
            notification.title!,
            style: const TextStyle(fontSize: 16),
          ),
          background: const Color(0xff0A1128).withOpacity(0.9),
          duration: const Duration(seconds: 2),
        );
      }
    });
  }

  @override
  void initState() {
    notifications = HiveManager.getInstance().retrieveData();
    registerNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xff0A1128),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Notifications",
          style: theme.textTheme.bodyMedium!.copyWith(
            fontSize: 20,
            color: const Color(0xffC6FAFF),
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          iconSize: 32,
          color: const Color(0xffC6FAFF),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(CupertinoIcons.back),
        ),
        backgroundColor: const Color(0xff0A1128),
      ),
      body: notifications.isNotEmpty
          ? ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final reversedIndex = notifications.length - 1 - index;
                return Slidable(
                  endActionPane: ActionPane(
                    extentRatio: 0.25,
                    motion: const DrawerMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) async {
                          setState(() {
                            HiveManager.getInstance().clearItem(
                              notifications[reversedIndex],
                            );
                            notifications.removeAt(reversedIndex);
                          });
                        },
                        borderRadius: BorderRadius.circular(15),
                        backgroundColor: const Color(0xFFEC4B4B),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: "delete",
                      ),
                    ],
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 15, bottom: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffCBEFF2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.notifications,
                            size: 30,
                            color: Color(0xff0A1128),
                          ),
                        ),
                        const SizedBox(width: 25),
                        Expanded(
                          flex: 12,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                notifications[reversedIndex].dataTitle ??
                                    notifications[reversedIndex].title!,
                                style: const TextStyle(
                                  color: Color(0xff0096A4),
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                notifications[reversedIndex].dataBody ??
                                    notifications[reversedIndex].body!,
                                style: const TextStyle(
                                  color: Color(0xff163A51),
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: Text(
                'No Notifications Found',
                style: TextStyle(
                  color: Color(0xffC6FAFF),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }
}
