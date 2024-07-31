import 'package:get/get.dart';
import '../../../data/models/employee.dart';
import '../../../utils/constants.dart';

class ApiServices extends GetConnect {
  static const int _maxRetries = 3;
  static const Duration _retryDelay = Duration(seconds: 2);

  Future<Response> _withRetry(
      Future<Response> Function() requestFunction) async {
    int retryCount = 0;
    while (retryCount < _maxRetries) {
      final response = await requestFunction();
      if (response.statusCode != 429) {
        return response;
      }
      retryCount++;
      await Future.delayed(_retryDelay);
    }
    return const Response(statusCode: 429, statusText: 'Too Many Requests');
  }

  Future<List<Employee>> getEmployeeData() async {
    var url = Constants.fetchEmployees;
    var response = await _withRetry(() => get(url));
    print('URL fetch: $url');
    print('Response Status fetch: ${response.statusCode}');
    print('Response Body fetch: ${response.body}');

    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      List<dynamic> data = response.body["data"];
      return data.map((e) => Employee.fromJson(e)).toList();
    }
  }

  Future<void> createEmployee(Employee employee) async {
    var url = Constants.createEmployee;
    var response = await _withRetry(() => post(url, employee.toJson()));
    print('URL create: $url');
    print('Request Body create: ${employee.toJson()}');
    print('Response Status create: ${response.statusCode}');
    print('Response Body create: ${response.body}');

    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    }
  }

  Future<void> updateEmployee(Employee employee) async {
    var url = '${Constants.updateEmployee}${employee.id}';
    var response = await _withRetry(() => put(url, employee.toJson()));
    print('URL update: $url');
    print('Request Body update: ${employee.toJson()}');
    print('Response Status update: ${response.statusCode}');
    print('Response Body update: ${response.body}');

    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    }
  }

  Future<void> deleteEmployee(int id) async {
    var url = '${Constants.deleteEmployee}$id';
    var response = await _withRetry(() => delete(url));
    print('URL delete: $url');
    print('Response Status delete: ${response.statusCode}');
    print('Response Body delete: ${response.body}');

    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    }
  }
}
