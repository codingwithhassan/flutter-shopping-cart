import 'package:get/get.dart';
import 'package:products/controllers/product_controller.dart';
import 'package:products/repositories/product_repository.dart';
import 'package:products/services/dummy_service.dart';
Future<void> init() async{
  
  Get.lazyPut(() => DummyService(serviceBaseUrl: "https://dummyjson.com"));
  Get.lazyPut(() => ProductRepository(dummyService: Get.find<DummyService>()));
          // Get.find() -> load previous loaded dependency
  Get.lazyPut(() => ProductController(productRepository: Get.find<ProductRepository>()));

}