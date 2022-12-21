import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:products/controllers/login_controller.dart';
import 'package:products/controllers/product_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:products/screens/home/product_item.dart';
import 'package:products/services/firebase/firebase_messaging_service.dart';
import 'package:products/utils/local_notifications.dart';
import 'package:products/utils/logging.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get/get.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class ProductsScreen extends StatefulWidget {
  static const routeName = '/';

  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  bool isShimmerEffectLoading = true;
  int countItems = 8;
  ScrollController scrollController = ScrollController();
  final ProductController productController = Get.find<ProductController>();
  final LoginController loginController = LoginController();
  final FirebaseMessagingService firebaseMessagingService =
      FirebaseMessagingService();
  final log = logger(ProductsScreen);

  void getData() {
    if(!isShimmerEffectLoading){
      setState(() {
        countItems += 1;
      });
    }
    productController.fetchProductList().then((products) {
      setState(() {
        isShimmerEffectLoading = false;
        countItems = productController.products.length;
      });
    });
  }

  Future<void> initFCM() async {
    await firebaseMessagingService.init();
    await LocalNotifications.initialize(flutterLocalNotificationsPlugin);
  }

  void _openProduct(context, int id) {
    Get.toNamed('/product/$id');
  }

  @override
  void initState() {
    super.initState();
    initFCM();
    getData();
    scrollController.addListener(_onScrollListView);
    log.i("initState Finished!");
  }

  void _onScrollListView() {
    setState(() {});
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent * 0.95 &&
        !isShimmerEffectLoading &&
        !productController.isLoading) {
      if (productController.hasMore) {
        getData();
        log.i("load more");
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  Widget _loadingItem() {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: const Color(0xFFD6D6D6),
      child: Container(
        margin: const EdgeInsets.all(5.0),
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(),
              ),
              Expanded(
                flex: 3,
                child: Container(),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _productItem(int index) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ProductItem(
          productData: productController.products[index],
          thumbnail: CachedNetworkImage(
            imageUrl: productController.products[index].thumbnail,
            placeholder: (context, url) => Image.asset(
              'assets/images/default.png',
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
            height: 80,
            width: 80,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          title: "$index - ${productController.products[index].title}",
          category: productController.products[index].category,
          price: productController.products[index].price,
          onOpen: () {
            _openProduct(context, productController.products[index].id);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purpleAccent,
              ),
              child: Text(
                'Shopping App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.message),
              title: Text('Messages'),
            ),
            const ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              onTap: loginController.logout,
              title: const Text('Logout'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Products",
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          LocalNotifications.showBigTextNotification(
              title: "Test",
              body: "Hi there!",
              fln: flutterLocalNotificationsPlugin);
        },
        child: const Icon(Icons.notification_add),
      ),
      body: Container(
        color: Colors.grey[300],
        child: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            controller: scrollController,
            itemCount: countItems,
            itemBuilder: (context, index) {
              if(!isShimmerEffectLoading && index >= productController.countItems){
                return const Padding(padding: EdgeInsets.only(top:20, bottom: 20),child: Center(child: CircularProgressIndicator()));
              }
              double itemOffset = index * 90;
              double totalOffset = scrollController.offset;

              double animationValue = 1;
              double opacity = 1;
              if (itemOffset < totalOffset) {
                double difference = (totalOffset - itemOffset) / 100;
                animationValue = difference;
                animationValue = (1 - animationValue).abs();
                opacity = animationValue.abs();
                if (opacity > 1) {
                  opacity = 1;
                } else if (opacity < 0) {
                  opacity = 0;
                }
              }
              return Opacity(
                opacity: opacity,
                child: Transform.scale(
                  alignment: Alignment.center,
                  scale: animationValue,
                  child: isShimmerEffectLoading ? _loadingItem() : _productItem(index),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
