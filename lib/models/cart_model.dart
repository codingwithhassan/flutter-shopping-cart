import 'package:hive/hive.dart';

part 'cart_model.g.dart';

@HiveType(typeId: 1)
class CartModel extends HiveObject{
  @HiveField(0)
  late final int productId;

  @HiveField(1)
  int quantity = 1;

  CartModel({required this.productId, this.quantity = 1});

  @override
  String toString() {
    return "{productId: $productId, quantity: $quantity}";
  }
}