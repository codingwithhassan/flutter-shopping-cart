import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:products/utils/logging.dart';

class LocalNotifications {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final log = logger(LocalNotifications);

  void initialize() {
    // initializationSettings  for Android


  }

  void createAndDisplayNotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        "shoppingApp",
        "shoppingAppChannel",
        importance: Importance.max,
      );

      await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      log.d(notification.toString());
      log.d(android.toString());

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        _notificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                icon: android?.smallIcon,
                // other properties...
              ),
            ));
      }
    } on Exception catch (e) {
      log.e(e);
    }
  }
}
