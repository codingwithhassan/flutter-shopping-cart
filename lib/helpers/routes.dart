import 'package:get/get.dart';
import 'package:products/screens/auth/login_screen.dart';
import 'package:products/screens/auth/signup_screen.dart';
import 'package:products/screens/home/products_screen.dart';
import 'package:products/screens/product_screen.dart';
import 'package:products/screens/splash_screen.dart';

class Routes {
  static const initialRoute = SplashScreen.routeName;

  static List<GetPage> all = <GetPage>[
    GetPage(
      name: SplashScreen.routeName,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: LoginScreen.routeName,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: SignupScreen.routeName,
      page: () => const SignupScreen(),
    ),
    GetPage(
      name: ProductsScreen.routeName,
      page: () => const ProductsScreen(),
    ),
    GetPage(
      name: ProductScreen.routeName,
      page: () => const ProductScreen(),
      transition: Transition.leftToRight,
    )
  ];
}
