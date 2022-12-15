import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:products/models/cart_model.dart';
import 'package:products/screens/auth/login_screen.dart';
import 'package:products/screens/auth/signup_screen.dart';
import 'package:products/screens/product_screen.dart';
import 'package:products/screens/home/products_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:products/screens/splash_screen.dart';
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
      initialRoute: SplashScreen.routeName,
      getPages: [
        GetPage(
          name: SplashScreen.routeName,
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: LoginScreen.routeName,
          page: () => const LoginScreen(),
        ),
        GetPage(
          name: SignupScreen.routeName,
          page: () => const SignupScreen(),
        ),
        GetPage(
          name: ProductsScreen.routeName,
          page: () => const ProductsScreen(),
        ),
        GetPage(
          name: ProductScreen.routeName,
          page: () => const ProductScreen(),
          transition: Transition.leftToRight,
        )
      ],
    );
  }
}
