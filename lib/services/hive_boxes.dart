import 'package:hive/hive.dart';
import 'package:products/models/cart_model.dart';

class Boxes {
  static Box<CartModel> getCart() => Hive.box<CartModel>('cart');
}