import 'package:get/get.dart';
import '../../../data/models/employee.dart';
import '../../../data/services/api_service.dart';

class EmployeeController extends GetxController
    with StateMixin<List<Employee>> {
  final ApiServices apiServices = ApiServices();
  @override
  void onInit() {
    fetchEmployees();
    super.onInit();
  }

  void fetchEmployees() async {
    try {
      var employees = await apiServices.getEmployeeData();
      change(employees, status: RxStatus.success());
    } catch (error) {
      change(null, status: RxStatus.error(error.toString()));
    }
  }

  void createEmployee(Employee employee) async {
    try {
      await apiServices.createEmployee(employee);
      Get.snackbar('Success', 'Employee created successfully');
      fetchEmployees();
    } catch (error) {
      Get.snackbar('Error', error.toString());
    }
  }

  void updateEmployee(Employee employee) async {
    try {
      await apiServices.updateEmployee(employee);
      Get.snackbar('Success', 'Employee updated successfully');
      fetchEmployees();
    } catch (error) {
      Get.snackbar('Error', error.toString());
    }
  }

  void deleteEmployee(int id) async {
    try {
      await apiServices.deleteEmployee(id);
      Get.snackbar('Success', 'Employee deleted successfully');
      fetchEmployees();
    } catch (error) {
      Get.snackbar('Error', error.toString());
    }
  }
}
