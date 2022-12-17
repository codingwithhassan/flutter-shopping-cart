import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:products/helpers/routes.dart';
import 'package:products/models/cart_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:products/services/firebase/firebase_messaging_service.dart';
import 'dependencies.dart' as dependencies;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("Handling a background message: ${message.messageId}");
  if (message.notification != null) {
    debugPrint(message.notification!.title);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // wait till dependencies loaded
  await dependencies.init();

  await Hive.initFlutter();
  // var directory = await getApplicationDocumentsDirectory();
  // Hive.init(directory.path);

  Hive.registerAdapter(CartModelAdapter());
  await Hive.openBox<CartModel>('cart');

  await Firebase.initializeApp();
  FirebaseMessagingService firebaseMessagingService = FirebaseMessagingService();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const ShoppingApp());
}

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Shopping App",
      theme: ThemeData(
        // primary color of floatingActionButton and appBar in Scaffold
        primarySwatch: Colors.purple,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.initialRoute,
      getPages: Routes.all,
    );
  }
}
