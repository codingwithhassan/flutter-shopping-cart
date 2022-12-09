import "package:flutter/material.dart";
import 'package:products/screens/products.dart';

void main() {
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
    ),
  ));
}