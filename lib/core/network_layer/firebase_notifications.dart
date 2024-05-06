import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:homey/main.dart';
import 'package:homey/pages/notifications_screen/notifications_screen.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

class FCM {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  final androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.defaultImportance,
  );
  final localNotifications = FlutterLocalNotificationsPlugin();

  static void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState
        ?.pushNamed(NotificationScreen.routeName, arguments: message);
  }

  //  Future<void> initLocalNotifications() async {
  //   const iOS  = DarwinInitializationSettings();
  //   const android = AndroidInitializationSettings("icon");
  //   const settings = InitializationSettings(android: android, iOS: iOS);
  //
  //   await localNotifications.initialize(
  //     settings,
  //     onDidReceiveNotificationResponse: (payload){
  //       final message = RemoteMessage.fromMap(jsonEncode(payload!));
  //       handleMessage(message);
  //     }
  //   );
  //   final platform = localNotifications.resolvePlatformSpecificImplementation(
  //     <AndroidFlutterLocalNotificationsPlugin>();
  //
  //   );
  // }

  static Future<void> initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((message) {
      fcmOnForeground();
    });
  }

  static Future<void> fcmInit() async {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    iosPermission();
    getToken();
    fcmOnForeground();
    initPushNotifications();
  }

  static Future<void> iosPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  static Future<String?> getToken() async {
    String? token = await messaging.getToken();
    print(token);
    return token;
  }

  static Future<void> fcmOnForeground() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        FirebaseFirestore.instance
            .collection("Notifications")
            .doc()
            .set({"message": notification.title});
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: "icon",
            ),
          ),
          payload: jsonEncode(message.toMap()),
        );
      }
    });
  }
}
