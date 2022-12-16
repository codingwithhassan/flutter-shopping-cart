import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:products/helpers/routes.dart';
import 'package:products/models/cart_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dependencies.dart' as dependencies;

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // wait till dependencies loaded
  await dependencies.init();

  await Hive.initFlutter();
  // var directory = await getApplicationDocumentsDirectory();
  // Hive.init(directory.path);

  Hive.registerAdapter(CartModelAdapter());
  await Hive.openBox<CartModel>('cart');

  await Firebase.initializeApp();

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
