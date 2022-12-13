import "package:flutter/material.dart";
import 'package:path_provider/path_provider.dart';
import 'package:products/models/cart.dart';
import 'package:products/models/product.dart';
import 'package:products/screens/products.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // var directory = await getApplicationDocumentsDirectory();
  // Hive.init(directory.path);

  Hive.registerAdapter(ProductDataAdapter());
  Hive.registerAdapter(CartAdapter());
  await Hive.openBox<Cart>('cart');

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
      ),
      body: Container(
        color: Colors.grey[300],
        child: const Products(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        child: const Icon(Icons.shopping_cart),
      ),
    ),
  ));
}