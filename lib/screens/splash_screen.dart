import 'package:flutter/material.dart';
import 'package:products/controllers/login_controller.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = LoginController();
    loginController.isLogin();

    return const Center(
      child: Text(
        "Shopping App",
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
