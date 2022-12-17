import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:products/utils/logging.dart';

class LocalNotifications {
  final log = logger(LocalNotifications);

  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize =
        const AndroidInitializationSettings("mipmap/ic_launcher");
    var initializationSettings =
        InitializationSettings(android: androidInitialize);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    logger(LocalNotifications).i("initialize");
  }

  static Future showBigTextNotification({
    required String title,
    required String body,
    var payload,
    required FlutterLocalNotificationsPlugin fln,
  }) async {
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'shoppingApp',
      'ShoppingAppName',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );

    var not = NotificationDetails(android: androidNotificationDetails);

    await fln.show(id, "$title ($id)", body, not);
  }
}
