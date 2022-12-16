import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:products/controllers/login_controller.dart';
import 'package:products/utils/logging.dart';
import 'package:products/screens/auth/login_screen.dart';
import 'package:products/widgets/rounded_button.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isLoading = false;
  final _formField = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final LoginController loginController = LoginController();
  final log = logger(SignupScreen);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _signUp() {
    if (_formField.currentState!.validate() && !isLoading) {
      setState(() {
        isLoading = true;
      });
      loginController.signUp(emailController.text.toString(),passwordController.text.toString(), () {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign up"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: height * 0.13,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Form(
                key: _formField,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText: "Email",
                        helperText: "e.g: abc@example.com",
                        prefixIcon: Icon(Icons.alternate_email),
                      ),
                      validator: (value) {
                        if (value!.isEmpty || !GetUtils.isEmail(value)) {
                          return 'Enter valid Email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Password",
                        helperText: "Your Strong Password",
                        prefixIcon: Icon(Icons.lock),
                      ),
                      validator: (value) {
                        if (value!.isEmpty ||
                            !GetUtils.isLengthBetween(value, 8, 20)) {
                          return 'Enter strong password between 8 and 20 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Confirm Password",
                        helperText: "Repeat your Password",
                        prefixIcon: Icon(Icons.lock),
                      ),
                      validator: (value) {
                        if (value!.isEmpty ||
                            passwordController.text != value.toString()) {
                          return 'Confirm Password should be same';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              RoundedButton(
                buttonText: "Register",
                isLoading: isLoading,
                onTap: _signUp,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Get.offAllNamed(LoginScreen.routeName);
                    },
                    child: const Text("Login"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
