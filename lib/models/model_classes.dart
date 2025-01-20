import 'package:flutter/material.dart';
import 'package:practice_1/models/complex_data_model.dart';
import 'package:practice_1/models/custom_data_model.dart';

class ModelClasses extends StatelessWidget {
  List<String> employees = [
    "Soumi",
    "Neel",
    "Pooja",
    "Sourya",
    "Gambu",
    "Shampoo"
  ];

  List<EmployeeDetails> details = [
    EmployeeDetails(id: 1, name: "Soumi", isActive: true),
    EmployeeDetails(id: 2, name: "Golu", isActive: false),
    EmployeeDetails(id: 3, name: "Neel", isActive: true),
    EmployeeDetails(id: 4, name: "Gambu", isActive: false),
    EmployeeDetails(id: 5, name: "Sourya", isActive: true),
    EmployeeDetails(id: 6, name: "Pooja", isActive: true),
    EmployeeDetails(id: 7, name: "Shampoo", isActive: false)
  ];

  List<CustomDataModel> employeeList = [
    CustomDataModel(name: "Soumi", role: "Android developer", isActive: true),
    CustomDataModel(name: "Golu", role: "web developer", isActive: false),
    CustomDataModel(name: "Neel", role: "flutter developer", isActive: true),
    CustomDataModel(name: "Gambu", role: "angular developer", isActive: false),
    CustomDataModel(name: "Sourya", role: "software developer", isActive: true),
    CustomDataModel(name: "Shampoo", role: "ios developer", isActive: false),
    CustomDataModel(name: "Pooja", role: "react developer", isActive: true),
    CustomDataModel(name: "Momo", role: "frontend developer", isActive: false),
    CustomDataModel(name: "Guwei", role: "backend developer", isActive: true)
  ];

  List<ComplexDataModel> developers = [
    ComplexDataModel(name: "Soumi", age: 24, isActive: true, details: Details(role: "android developer", experience: "beginner")),
    ComplexDataModel(name: "Soumi", age: 24, isActive: true, details: Details(role: "android developer", experience: "beginner")),
    ComplexDataModel(name: "Soumi", age: 24, isActive: true, details: Details(role: "android developer", experience: "beginner")),
    ComplexDataModel(name: "Soumi", age: 24, isActive: true, details: Details(role: "android developer", experience: "beginner")),
    ComplexDataModel(name: "Soumi", age: 24, isActive: true, details: Details(role: "android developer", experience: "beginner")),
    ComplexDataModel(name: "Soumi", age: 24, isActive: true, details: Details(role: "android developer", experience: "beginner")),
    ComplexDataModel(name: "Soumi", age: 24, isActive: true, details: Details(role: "android developer", experience: "beginner")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Model Class"),
        ),
        body: ListView.builder(
            itemCount: developers.length,
            itemBuilder: (context, index) {
              return ListTile(
                // leading: CircleAvatar(
                //   backgroundColor: Colors.blue[100],
                //   child: Text(
                //     employeeList[index].id.toString(),
                //     style: TextStyle(fontWeight: FontWeight.bold),
                //   ),
                // ),
                leading: CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: Text(developers[index].name.toString()),
                subtitle: Text("${developers[index].details!.role} || ${developers[index].details!.experience}"),
                trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.star,
                      color: developers[index].isActive == true
                          ? const Color.fromARGB(255, 248, 223, 1)
                          : Colors.grey,
                    )),
              );
            }));
  }
}

class EmployeeDetails {
  int id;
  String name;
  bool isActive;

  EmployeeDetails(
      {required this.id, required this.name, required this.isActive});
}
