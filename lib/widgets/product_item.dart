import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:products/Boxes.dart';
import 'package:products/models/cart.dart';
import 'package:products/models/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.productData,
    required this.thumbnail,
    required this.title,
    required this.category,
    required this.price,
    required this.onOpen,
  });

  final ProductData productData;
  final Widget thumbnail;
  final String title;
  final String category;
  final int price;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: InkWell(
              child: thumbnail,
              onTap: () {
                onOpen();
              },
            ),
          ),
          Expanded(
            flex: 3,
            child: _Description(
              title: title,
              user: category,
              price: price,
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
                onPressed: () {
                  productData.addToCart();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Item added to Cart"),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.add_shopping_cart,
                  color: Colors.blueAccent,
                )),
          )
        ],
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({
    required this.title,
    required this.user,
    required this.price,
  });

  final String title;
  final String user;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 8.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            user,
            style: const TextStyle(fontSize: 10.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            '$price USD',
            style: const TextStyle(fontSize: 10.0),
          ),
        ],
      ),
    );
  }
}
