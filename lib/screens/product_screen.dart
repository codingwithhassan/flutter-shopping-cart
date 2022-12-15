import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:products/boxes.dart';
import 'package:products/controllers/product_controller.dart';
import 'package:products/logging.dart';
import 'package:products/models/cart_model.dart';
import 'package:products/models/product_model.dart';
import 'package:products/widgets/cart_counter.dart';
import 'package:get/get.dart';

class ProductScreen extends StatefulWidget {
  static const routeName = '/product/:id';

  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final String id = Get.parameters['id'].toString();
  final Box<CartModel> cartBox = Boxes.getCart();
  CartModel? itemInCart;
  final ProductController productController = Get.find<ProductController>();
  final log = logger(ProductScreen);

  final PageController controller = PageController();

  late ProductModel productData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    ProductModel? productModel = productController.getProductById(int.parse(id));
    setState(() {
      productData = productModel!;
      isLoading = false;
    });
    _setItemInCart();
  }

  void _setItemInCart() {
    var cartItems = cartBox.values
        .cast<CartModel>()
        .where((element) => element.productId == int.parse(id));

    itemInCart = null;
    if (cartItems.isNotEmpty) {
      itemInCart = cartItems.first;
    }

    log.d(itemInCart);
    log.d(cartBox.values.cast<CartModel>());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text("Detail Screen"),
      ),
      body: !isLoading
          ? SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight / 2.0,
                    child: PageView.builder(
                      controller: controller,
                      itemCount: productData.images.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CachedNetworkImage(
                          imageUrl: productData.images[index],
                          placeholder: (context, url) => Image.asset(
                            'assets/images/default.png',
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              productData.title.toString(),
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      r'Price: $' +
                                          productData.price.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      r'Available Stock: ' +
                                          productData.stock.toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CartCounter(
                                      productData: productData,
                                      total: itemInCart != null
                                          ? itemInCart!.quantity
                                          : 0,
                                      onChange: () {
                                        setState(() {
                                          _setItemInCart();
                                        });
                                      },
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: Text(
                          productData.description.toString(),
                          style: const TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const Text(
                                  r'Categories:   ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Chip(
                                  padding: const EdgeInsets.all(0),
                                  backgroundColor: Colors.blue,
                                  label: Text(productData.category.toString(),
                                      style:
                                          const TextStyle(color: Colors.white)),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const Text(
                                  r'Brands:   ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Chip(
                                  padding: const EdgeInsets.all(0),
                                  backgroundColor: Colors.green,
                                  label: Text(productData.brand.toString(),
                                      style:
                                          const TextStyle(color: Colors.white)),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )
          : Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: double.infinity,
              child: const CircularProgressIndicator(),
            ),
    );
  }
}
