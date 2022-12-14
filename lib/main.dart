import "package:flutter/material.dart";
import 'package:products/models/cart_model.dart';
import 'package:products/screens/products.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dependencies.dart' as dependencies;

void main() async {

  WidgetsFlutterBinding.ensureInitialized();  // wait till dependencies loaded
  await dependencies.init();

  await Hive.initFlutter();
  // var directory = await getApplicationDocumentsDirectory();
  // Hive.init(directory.path);

  Hive.registerAdapter(CartModelAdapter());
  await Hive.openBox<CartModel>('cart');

  runApp(MaterialApp(
    title: "Products",
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        centerTitle: true,
        title: const Text(
          "Products",
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart),
          )
        ],
      ),
      body: Container(
        color: Colors.grey[300],
        child: const Products(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.favorite),
      ),
    ),
  ));
}
