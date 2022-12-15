import 'package:hive/hive.dart';
import 'package:products/boxes.dart';
import 'package:products/logging.dart';
import 'package:products/models/cart_model.dart';
import 'package:logger/logger.dart';

class ProductModel {
  late int id;
  late String title;
  late String description;
  late int price;
  late double discountPercentage;
  late double rating;
  int stock = 0;
  late String brand;
  late String category;
  late String thumbnail;
  List<String> images = [];

  ProductModel(
    this.id, {
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  ProductModel.fromJson(Map json) {
    id = json['id'] as int;
    title = json['title'] as String;
    description = json['description'] as String;
    price = json['price'] as int;
    discountPercentage = json['discountPercentage'] as double;
    rating = json['rating'].toDouble() as double;
    stock = json['stock'] as int;
    brand = json['brand'] as String;
    category = json['category'] as String;
    thumbnail = json['thumbnail'] as String;
    images = json['images'].cast<String>();
  }

  void addToCart() {
    var log = logger(ProductModel);
    CartModel? itemInCart = _getCartProduct();
    if (itemInCart != null) {
      itemInCart.quantity = itemInCart.quantity + 1;
      itemInCart.save();
      log.i('+1 added to cart');
    } else {
      Boxes.getCart().add(CartModel(productId: id));
      log.i('added to cart');
    }
  }

  void minusToCart() {
    var log = logger(ProductModel);
    CartModel? itemInCart = _getCartProduct();

    if (itemInCart != null && itemInCart.quantity != 0) {
      if (itemInCart.quantity == 1) {
        itemInCart.delete();
      } else {
        itemInCart.quantity = itemInCart.quantity - 1;
        itemInCart.save();
      }
      log.i('-1 to cart');
    }
  }

  CartModel? _getCartProduct(){
    final Box<CartModel> cartBox = Boxes.getCart();
    var cartItems = cartBox.values
        .cast<CartModel>()
        .where((element) => element.productId == id);

    CartModel? itemInCart;
    if (cartItems.isNotEmpty) {
      itemInCart = cartItems.first;
    }
    return itemInCart;
  }

  @override
  String toString() {
    return "{id=$id, title=$title}";
  }
}
