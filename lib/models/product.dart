import 'package:hive/hive.dart';
import 'package:products/Boxes.dart';
import 'package:products/models/cart.dart';

part 'product.g.dart';

@HiveType(typeId: 0)
class ProductData extends HiveObject {
  @HiveField(0)
  late int id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late String description;

  @HiveField(3)
  late int price;

  @HiveField(4)
  late double discountPercentage;

  @HiveField(5)
  late double rating;

  @HiveField(6)
  int stock = 0;

  @HiveField(7)
  late String brand;

  @HiveField(8)
  late String category;

  @HiveField(9)
  late String thumbnail;

  @HiveField(10)
  List<String> images = [];

  ProductData(
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

  ProductData.fromJson(Map json) {
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

  void addToCart(){
    final Box<Cart> cartBox = Boxes.getCart();
    Cart? itemInCart;
    var cartItems = cartBox.values
        .cast<Cart>()
        .where((element) => element.product_id == id);

    if (cartItems.isNotEmpty) {
      itemInCart = cartItems.first;
    }
    if (itemInCart != null) {
      itemInCart!.quantity = itemInCart!.quantity + 1;
      itemInCart!.save();
      print('+1 added to cart');
    } else {
      cartBox.add(Cart(product_id: id));
      print('added to cart');
    }
  }

  @override
  String toString() {
    return "{id=$id, title=$title}";
  }
}
