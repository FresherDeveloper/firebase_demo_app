import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import '../../presentation/pages/auth/auth_screen.dart';
import '../../presentation/pages/home/home_page.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var obscureText = true.obs;
  var isSignUpMode = false.obs;
  var isAuthenticated = false.obs;

  AuthService authService = AuthService();
  final GetStorage _storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _autoLogin();
  }

  void signUp(String email, String password) async {
    isLoading.value = true;

    try {
      User? user = await authService.signUp(email, password);
      isLoading.value = false;

      if (user != null) {
        Get.snackbar(
          'Success',
          'Sign Up Successful',
        );

        toggleSignUpMode();
      } else {
        Get.snackbar(
          'Error',
          'Sign Up Failed',
        );
      }
    } catch (e) {
      isLoading.value = false;

      Get.snackbar(
        'Error',
        'Sign Up Failed: $e',
      );
    }
  }

  void login(String email, String password) async {
    isLoading.value = true;
    User? user = await authService.login(email, password);
    isLoading.value = false;
    if (user != null) {
      _storage.write('email', email);
      _storage.write('password', password);
      isAuthenticated.value = true;
      Get.offAll(() => HomePage());
      Get.snackbar('Success', 'Login Successfully');
    } else {
      Get.snackbar('Error', 'Login Failed');
    }
  }

  void logout() async {
    await authService.logout();
    _storage.erase();
    isAuthenticated.value = false;
    Get.offAll(() => AuthScreen());
  }

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }

  void toggleSignUpMode() {
    isSignUpMode.value = !isSignUpMode.value;
  }

  void _autoLogin() {
    String? email = _storage.read('email');
    String? password = _storage.read('password');
    if (email != null && password != null) {
      login(email, password);
    }
  }
}
