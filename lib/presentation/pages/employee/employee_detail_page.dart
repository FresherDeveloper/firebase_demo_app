import 'package:flutter/material.dart';

import '../../../data/models/employee.dart';

class EmployeeDetailPage extends StatelessWidget {
  final Employee employee;

  const EmployeeDetailPage({required this.employee, super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Page"),
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Container(
          color: Colors.grey,
          alignment: Alignment.center,
          width: screenWidth / 2,
          height: screenHeight / 2,
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 30,
                    child: employee.profileImage.isEmpty
                        ? const Icon(Icons.person)
                        : Image.network(employee.profileImage),
                  ),
                ),
                // employee.profileImage.isEmpty?const Icon(Icons.person):Image.network(employee.profileImage),
                Text('Name: ${employee.employeeName}',
                    style: const TextStyle(fontSize: 20)),
                Text('Salary: \$${employee.employeeSalary}',
                    style: const TextStyle(fontSize: 20)),
                Text('Age: ${employee.employeeAge}',
                    style: const TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
