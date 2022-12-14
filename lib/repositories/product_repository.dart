import 'package:get/get.dart';
import 'package:products/models/product_model.dart';
import 'package:products/services/dummy_service.dart';

class ProductRepository extends GetxService {
  final DummyService dummyService;

  ProductRepository({required this.dummyService});

  Future<List<ProductModel>> getProductList() async {
    Response response = await dummyService.get("/products");
    if (response.statusCode != 200) {
      return [];
    }

    List<ProductModel> products = [];
    response.body['products'].forEach((json) {
      products.add(ProductModel.fromJson(json));
    });
    return products;
  }
}
