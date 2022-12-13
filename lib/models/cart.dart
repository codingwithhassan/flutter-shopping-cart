import 'package:hive/hive.dart';
import 'package:products/models/product.dart';

part 'cart.g.dart';

@HiveType(typeId: 1)
class Cart extends HiveObject{
  @HiveField(0)
  late final int product_id;

  @HiveField(1)
  int quantity = 1;

  Cart({required this.product_id, this.quantity = 1});

  @override
  String toString() {
    return "{product_id: $product_id, quantity: $quantity}";
  }
}