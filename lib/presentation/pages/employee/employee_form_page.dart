import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/controllers/employee_controller.dart';
import '../../../data/models/employee.dart';
import '../responsive.dart';

class EmployeeFormPage extends StatefulWidget {
  final Employee? employee;
  const EmployeeFormPage({super.key, this.employee});

  @override
  State<EmployeeFormPage> createState() => _EmployeeFormPageState();
}

class _EmployeeFormPageState extends State<EmployeeFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _salaryController = TextEditingController();
  final _ageController = TextEditingController();
  final EmployeeController _employeeController = Get.find();

  @override
  void initState() {
    super.initState();
    if (widget.employee != null) {
      _nameController.text = widget.employee!.employeeName;
      _salaryController.text = widget.employee!.employeeSalary.toString();
      _ageController.text = widget.employee!.employeeAge.toString();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _salaryController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.employee == null ? 'Create Employee' : 'Update Employee'),
      ),
      body: Center(
        child: SizedBox(
          width: Responsive.isDesktop(context)
              ? screenWidth / 2
              : screenWidth * .7,
          height: Responsive.isDesktop(context)
              ? screenHeight / 2
              : screenHeight * .7,
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        // border: OutlineInputBorder(
                        //   borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        // ),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter a name' : null,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _salaryController,
                      decoration: const InputDecoration(
                        labelText: 'Salary',
                        // border: OutlineInputBorder(
                        //   borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        // ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter a salary' : null,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _ageController,
                      decoration: const InputDecoration(
                        labelText: 'Age',
                        // border: OutlineInputBorder(
                        //   borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        // ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter an age' : null,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          var employee = Employee(
                            id: widget.employee?.id ?? 0,
                            employeeName: _nameController.text,
                            employeeSalary: int.parse(_salaryController.text),
                            employeeAge: int.parse(_ageController.text),
                            profileImage: '',
                          );
                          if (widget.employee == null) {
                            _employeeController.createEmployee(employee);
                          } else {
                            _employeeController.updateEmployee(employee);
                          }
                          Get.back();
                        }
                      },
                      child:
                          Text(widget.employee == null ? 'Create' : 'Update'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
