import 'package:hive_flutter/hive_flutter.dart';
import 'package:homey/pages/notifications_screen/models/notification_model.dart';

class HiveManager {
  HiveManager._();

  static HiveManager? _instance;


  static HiveManager getInstance() {
    _instance ??= HiveManager._();
    return _instance!;
  }

  static String _boxKey = "Notifications";

  static Future<void> init() async {
    await Hive.initFlutter();
    _registerAdapters();
    await _openHiveBoxes();
  }

  static void _registerAdapters() {
    Hive.registerAdapter(NotificationModelAdapter());
  }

  static Future<void> _openHiveBoxes() async {
    await Hive.openBox<NotificationModel>(_boxKey);
  }

  void cacheData(NotificationModel dataItem) async {
    var box = Hive.box<NotificationModel>(_boxKey);
    box.add(dataItem);
  }

  List<NotificationModel> retrieveData() {
    var box = Hive.box<NotificationModel>(_boxKey);
    return box.values.toList();
  }

  void clearItem<NotificationModel>(NotificationModel dataItem) async {
    var box = Hive.box<NotificationModel>(_boxKey);
    await box.clear();
  }
}