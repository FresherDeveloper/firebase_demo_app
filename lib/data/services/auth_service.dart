import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Login Failed');
    } catch (e) {
      Get.snackbar('Error', e.toString());
      print(e.toString());
      return null;
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Login Failed');
    } catch (e) {
      Get.snackbar('Error', e.toString());
      print(e.toString());
      return null;
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      Get.snackbar('Success', 'LogOut successfully');
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'LogOut Failed');
    } catch (e) {
      Get.snackbar('Error', e.toString());
      print(e.toString());
    }
  }
}
