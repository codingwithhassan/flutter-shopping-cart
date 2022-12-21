import 'package:get/get.dart';
import 'package:products/services/dummy_service.dart';

class ProductRepository extends GetxService {
  final DummyService dummyService;

  ProductRepository({required this.dummyService});

  Future<Response> getProductList(int skip, [int limit = 20]) async {
    Response response = await dummyService.get("/products?limit=$limit&skip=$skip");
    return response;
  }
}
