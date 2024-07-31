import 'package:get/get.dart';
import 'package:planet_media_sample_project/data/controllers/employee_controller.dart';

import '../data/controllers/auth_controllers.dart';

class OverAllBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmployeeController>(() => EmployeeController());
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
