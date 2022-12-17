import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:products/helpers/app_constants.dart';
import 'package:products/utils/local_notifications.dart';
import 'package:products/utils/logging.dart';

class FirebaseMessagingService {
  final log = logger(FirebaseMessagingService);
  final LocalNotifications localNotifications = LocalNotifications();

  FirebaseMessaging get firebaseMessaging => FirebaseMessaging.instance;

  Future<void> init() async {
    // 1. If app is in terminated state and you get a notification
    // Called when open the app everytime
    firebaseMessaging.getInitialMessage().then(
      (message) {
        log.i("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          if (message.data['_id'] != null) {
            // navigate to anywhere
            log.s(message.data['_id']);
          }
        }
      },
    );

    // 2. This method only call when App in foreground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        log.i("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          log.d("onMessage.data ${message.data}");
          // localNotifications.createAndDisplayNotification(message);
        }
      },
    );

    // 3. IF App in background and not terminated (not closed)
    // Called when user open app through notification
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        log.i("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          log.d("onMessageOpenedApp.data ${message.data['_id']}");
        }
      },
    );

    await getToken();
  }

  Future<void> backgroundHandler(RemoteMessage message) async {
    log.i("onBackgroundMessage->backgroundHandler");
    log.d(message.data.toString());
    if (message.notification != null) {
      log.d(message.notification!.title);
    }
  }

  Future<String?> getToken() async {
    String? token = await firebaseMessaging.getToken(
      vapidKey: AppConstants.firebaseMessagingApiKey,
    );
    log.i("Token: $token");

    return token;
  }
}
