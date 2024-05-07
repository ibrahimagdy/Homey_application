class NotificationModel {
  final String? title;
  final String? body;
  final String? dataTitle;
  final String? dataBody;

  NotificationModel({this.dataTitle, this.dataBody, this.title, this.body});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'],
      body: json['body'],
      dataTitle: json['dataTitle'],
      dataBody: json['dataBody'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'dataTitle': dataTitle,
      'dataBody': dataBody,
    };
  }
}