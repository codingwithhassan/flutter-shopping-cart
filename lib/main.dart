import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:products/models/cart_model.dart';
import 'package:products/screens/product_screen.dart';
import 'package:products/screens/products_screen.dart';
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

  runApp(const ShoppingApp());
}

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Shopping App",
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
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
