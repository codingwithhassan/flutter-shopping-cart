import 'package:flutter/material.dart';
import 'package:products/controllers/login_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:products/screens/auth/login_screen.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = LoginController();
    return AnimatedSplashScreen.withScreenFunction(
      backgroundColor: Colors.white,
      splash: Lottie.asset("assets/lottie/loading.json"),
      splashTransition: SplashTransition.decoratedBoxTransition,
      pageTransitionType: PageTransitionType.bottomToTop,
      animationDuration: const Duration(seconds: 1),
      screenFunction: () async {
        return const LoginScreen();
      },
    );
  }
}
