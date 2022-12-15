import 'dart:async';
import 'package:get/get.dart';
import 'package:products/logging.dart';
import 'package:products/screens/products_screen.dart';

class LoginController {
  static final log = logger(LoginController);
  void isLogin() {
    log.d("Is user login?");

    // or Timer.periodic
    Timer(const Duration(seconds: 1), () {
      Get.offNamed(ProductsScreen.routeName);
    });
  }
}
