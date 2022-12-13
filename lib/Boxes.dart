import 'package:hive/hive.dart';
import 'package:products/models/cart.dart';

class Boxes {
  static Box<Cart> getCart() => Hive.box<Cart>('cart');
}