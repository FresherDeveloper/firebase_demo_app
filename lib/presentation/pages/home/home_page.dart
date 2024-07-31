import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planet_media_sample_project/presentation/pages/auth/auth_screen.dart';
import '../../../data/controllers/auth_controllers.dart';
import '../../../data/controllers/employee_controller.dart';
import '../employee/employee_detail_page.dart';
import '../employee/employee_form_page.dart';
import '../responsive.dart';

class HomePage extends GetView<EmployeeController> {
  final AuthController authController = Get.put(AuthController());
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text("Employee List"),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () {
              Get.to(() => const EmployeeFormPage());
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () {
              authController.logout();
              Get.to(() => AuthScreen());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: ResponsiveLayout(
            mobile: _buildEmployeeList(),
            tablet: _buildEmployeeList(),
            desktop: _buildEmployeeList(columnSpacing: 250),
            //  Row(
            //   children: [
            //     Expanded(flex: 1, child: _buildEmployeeList()),
            //     Expanded(flex: 2, child: Placeholder()), // Placeholder for details
            //   ],
            //),
          ),
        ),
      ),
    );
  }

  Widget _buildEmployeeList({double? columnSpacing}) {
    return controller.obx(
      (data) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            showCheckboxColumn: false,
            columnSpacing: columnSpacing,
            headingRowColor:
                WidgetStateColor.resolveWith((states) => Colors.grey),
            decoration: BoxDecoration(border: Border.all()),
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'ID',
                ),
              ),
              DataColumn(
                label: Text(
                  'Name',
                ),
              ),
              DataColumn(
                label: Text(
                  'Age',
                ),
              ),
              DataColumn(
                label: Text(
                  'Salary',
                ),
              ),
              DataColumn(
                label: Text(
                  'Actions',
                ),
              ),
            ],
            rows: data!.map<DataRow>((employee) {
              return DataRow(
                cells: <DataCell>[
                  DataCell(Text(employee.id.toString())),
                  DataCell(Text(employee.employeeName)),
                  DataCell(Text(employee.employeeAge.toString())),
                  DataCell(Text(employee.employeeSalary.toString())),
                  DataCell(Row(
                    children: [
                      IconButton(
                        color: Colors.orangeAccent,
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Get.to(() => EmployeeFormPage(employee: employee));
                        },
                      ),
                      IconButton(
                        color: Colors.redAccent,
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          controller.deleteEmployee(employee.id);
                        },
                      ),
                    ],
                  )),
                ],
                onSelectChanged: (selected) {
                  if (selected != null && selected) {
                    Get.to(() => EmployeeDetailPage(employee: employee));
                  }
                },
              );
            }).toList(),
          ),
        );
      },
      onError: (error) => Center(
          child: Text(
        error!,
      )),
    );
  }
}
