import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/controllers/auth_controllers.dart';
import '../../../data/controllers/employee_controller.dart';
import '../responsive.dart';

class AuthScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final EmployeeController empController = Get.put(EmployeeController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => Text(
                    authController.isSignUpMode.value ? "Sign Up" : "Login",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  )),
              const SizedBox(height: 20),
              SizedBox(
                width: Responsive.isDesktop(context)
                    ? screenWidth / 2
                    : screenWidth * .7,
                height: Responsive.isDesktop(context)
                    ? screenHeight / 2
                    : screenHeight * .7,
                child: Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: emailController,
                          decoration: const InputDecoration(labelText: 'Email'),
                        ),
                        Obx(() => TextField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    authController.obscureText.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: authController.toggleObscureText,
                                ),
                              ),
                              obscureText: authController.obscureText.value,
                            )),
                        const SizedBox(height: 20),
                        Obx(() {
                          if (authController.isLoading.value) {
                            return const CircularProgressIndicator();
                          } else {
                            return Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    if (authController.isSignUpMode.value) {
                                      authController.signUp(
                                          emailController.text,
                                          passwordController.text);
                                    } else {
                                      authController.login(emailController.text,
                                          passwordController.text);
                                    }
                                  },
                                  child: Obx(() => Text(
                                      authController.isSignUpMode.value
                                          ? 'Sign Up'
                                          : 'Login')),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Flexible(
                                    child: TextButton(
                                      onPressed: () {
                                        authController.toggleSignUpMode();
                                      },
                                      child: Obx(() => Text(
                                            authController.isSignUpMode.value
                                                ? 'Already have an account? Login'
                                                : 'Don\'t have an account? Sign Up',
                                            style: TextStyle(
                                                fontSize:
                                                    Responsive.isMobile(context)
                                                        ? 10
                                                        : 14),
                                          )),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
