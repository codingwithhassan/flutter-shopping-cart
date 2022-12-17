import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:products/controllers/login_controller.dart';
import 'package:products/screens/auth/login_screen.dart';
import 'package:products/utils/logging.dart';

class AuthMiddleware extends GetMiddleware{
  @override
  int? get priority => 1;

  final LoginController loginController = LoginController();
  final log = logger(AuthMiddleware);

  @override
  RouteSettings? redirect(String? route){
    if(!loginController.isLogin()){
      return const RouteSettings(name: LoginScreen.routeName);
    }
    return null;
  }

  // This function will be called before anything created we can use it to
  // change something about the page or give it new page
  @override
  GetPage? onPageCalled(GetPage? page) {
    log.i("onPageCalled");
    return super.onPageCalled(page);
  }

  // This function will be called before the bindings are initialized.
  // here we can change bindings for this page
  @override
  List<Bindings>? onBindingsStart(List<Bindings>? bindings) {
    log.i("onBindingsStart");
    return super.onBindingsStart(bindings);
  }

  // This function will be called right after Bindings are initialized.
  // Here we can do something after bindings created and before creating the page widgets
  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {
    log.i("onPageBuildStart");
    return super.onPageBuildStart(page);
  }

  // This function will be called when page build and widgets of page will be shown
  @override
  Widget onPageBuilt(Widget page) {
    log.i("onPageBuilt");
    return super.onPageBuilt(page);
  }

  // This function will be called after disposing all the related objects
  @override
  void onPageDispose() {
    log.i("onPageDispose");
    super.onPageDispose();
  }
}