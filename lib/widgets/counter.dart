import 'package:flutter/material.dart';
import 'package:products/models/product_model.dart';

class Counter extends StatelessWidget {
  final ProductModel productData;
  final VoidCallback onChange;
  final int total;
  const Counter(
      {Key? key, required this.productData, required this.onChange, required this.total})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            productData.addToCart();
            onChange();
          },
          icon: const Icon(
            Icons.add,
            color: Colors.blueAccent,
            size: 30,
          ),
        ),
        Text(
          total.toString(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400
          ),
        ),
        IconButton(
          onPressed: () {
            productData.minusToCart();
            onChange();
          },
          icon: const Icon(
            Icons.minimize,
            color: Colors.blueAccent,
            size: 30,
          ),
        ),
      ],
    );
  }
}
