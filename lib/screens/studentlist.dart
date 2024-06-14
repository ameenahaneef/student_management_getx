import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studentmanagementgetx/controller/studentcontroller.dart';
import 'package:studentmanagementgetx/models/studentmodel.dart';
import 'package:studentmanagementgetx/screens/home.dart';
import 'package:studentmanagementgetx/screens/studentdetails.dart';

class StudentList extends StatelessWidget {
  final StudentController _studentController = Get.put(StudentController());

  StudentList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: const Text(
            'Student List',
          ),
          actions: [
            IconButton(
                onPressed: () {
                
                  Get.to(() => HomeScreen());
                },
                icon: const Icon(
                  Icons.add,
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(children: [
            TextFormField(
              onChanged: (value) {
                _studentController.setSearchTxt(value);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.green),
                ),
                hintText: 'Search by Name',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GetBuilder<StudentController>(builder: (controller) {
              return StreamBuilder(
                stream: _studentController.searchTxt == null
                    ? _studentController.getStudents()
                    : _studentController.searchStudents(
                        _studentController.searchTxt!.toLowerCase()),
                builder: (context, snapshot) {
                  List students = snapshot.data?.docs ?? [];
                  if (students.isEmpty) {
                    return const Center(
                      child: Text(
                        'No students',
                        style: TextStyle(color: Colors.red, fontSize: 20),
                      ),
                    );
                  }
                  return Expanded(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 10),
                        itemCount: students.length,
                        itemBuilder: (context, index) {
                          StudentModel studentModel = students[index].data();
                          String studentId = students[index].id;

                          return GestureDetector(
                            onTap: () {
                              Get.to(() => StudentDetails(
                                  student: studentModel, id: studentId));
                            },
                            child: Card(
                              elevation: 3,
                              color: const Color.fromARGB(255, 174, 158, 109),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundImage: FileImage(
                                            File(studentModel.imageUrl)),
                                      ),
                                      Text(
                                        studentModel.name,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        studentModel.rollno,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                },
              );
            }),
          ]),
        ));
  }
}
