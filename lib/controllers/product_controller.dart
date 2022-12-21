import 'package:get/get.dart';
import 'package:products/models/product_model.dart';
import 'package:products/repositories/product_repository.dart';

class ProductController extends GetxController{
  final ProductRepository productRepository;

  ProductController({ required this.productRepository});

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;
  bool isLoading = false;
  bool hasMore = true;
  int skip = 0;
  int countItems = 0;

  Future<void> fetchProductList() async {
    isLoading = true;
    Response response = await productRepository.getProductList(skip);
    if (response.statusCode != 200) {
      // return Future.error(response.statusText!);
      _products = [];
    }

    var body = response.body;
    body['products'].forEach((json) {
      _products.add(ProductModel.fromJson(json));
    });
    _products = products;
    countItems = products.length;
    hasMore = countItems < body['total'];
    isLoading = false;
    skip += 20;
    update(); // like setState() -> update UI GetBuilder Widget
  }

  ProductModel? getProductById(int productId) {
    ProductModel? productModel;
    var list = _products.where((element) => element.id == productId);
    if (list.isNotEmpty) {
      productModel = list.first;
    }
    return productModel;
  }
}