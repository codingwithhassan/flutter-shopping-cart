import 'package:get/get.dart';
import 'package:products/models/product_model.dart';
import 'package:products/repositories/product_repository.dart';

class ProductController extends GetxController{
  final ProductRepository productRepository;

  ProductController({ required this.productRepository});

  List<dynamic> _products = [];
  List<dynamic> get products => _products;

  Future<void> setProductList() async {
    List<ProductModel> products = await productRepository.getProductList();
    _products = products;
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