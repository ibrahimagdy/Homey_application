import 'package:hive/hive.dart';

part 'notification_model.g.dart';

@HiveType(typeId: 0)
class NotificationModel {
  @HiveField(0)
  final String? title;
  @HiveField(1)
  final String? body;
  @HiveField(2)
  final String? dataTitle;
  @HiveField(3)
  final String? dataBody;

  NotificationModel({this.dataTitle, this.dataBody, this.title, this.body});


}