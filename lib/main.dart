import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:planet_media_sample_project/binding/binding.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:planet_media_sample_project/data/controllers/auth_controllers.dart';
import 'package:planet_media_sample_project/presentation/pages/auth/auth_screen.dart';
import 'package:planet_media_sample_project/presentation/pages/home/home_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: OverAllBinding(),
      home: Obx(() {
        return authController.isAuthenticated.value ? HomePage() : AuthScreen();
      }),
    );
  }
}
