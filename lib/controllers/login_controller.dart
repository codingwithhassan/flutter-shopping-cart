import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:products/logging.dart';
import 'package:products/screens/auth/login_screen.dart';
import 'package:products/utils/alert.dart';

class LoginController {
  static final log = logger(LoginController);
  static final auth = FirebaseAuth.instance;

  bool isLogin() {
    log.d("Is user login?");
    return auth.currentUser != null;

    // or Timer.periodic
    // Timer(const Duration(seconds: 1), () {
    //   Get.offNamed(LoginScreen.routeName);
    // });
  }

  void logout() {
    auth.signOut().then(
      (value) {
        Alert.success("User Logged out!");
        Get.offNamed(LoginScreen.routeName);
      },
    ).onError(
      (error, stackTrace) {
        log.er(error.toString());
      },
    );
  }

  void signIn(String email, String password, Function? callback) {
    auth.signInWithEmailAndPassword(email: email, password: password).then(
      (value) {
        Alert.success("${value.user!.email} Logged In successfully!");
        Get.offAllNamed('/');
      },
    ).onError(
      (error, stackTrace) {
        log.e(error.toString());
        if (callback != null) callback();
        Alert.error(error.toString());
      },
    );
  }

  void signUp(String email, String password, Function? callback) {
    auth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then(
          (value) {
        Alert.success("Account created successfully!");
        Get.offAllNamed(LoginScreen.routeName);
      },
    )
        .onError((error, stackTrace){
      log.e(error.toString());
      Alert.error(error.toString());
      if(callback != null) callback();
    });
  }
}
