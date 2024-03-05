import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studentmanagementgetx/constants/constant.dart';
import 'package:studentmanagementgetx/controller/studentcontroller.dart';
import 'package:studentmanagementgetx/models/studentmodel.dart';
import 'package:studentmanagementgetx/screens/editscreen.dart';

class StudentDetails extends StatelessWidget {
  final StudentModel student;
  final String id;
  final StudentController _studentController = Get.put(StudentController());
  StudentDetails({
    super.key,
    required this.student,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student Details',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 50, right: 50, top: 80),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: const Color.fromARGB(255, 170, 156, 117)),
            width: 300,
            height: 500,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 90,
                      backgroundImage: FileImage(File(student.imageUrl)),
                    ),
                  ),
                  Text(
                    'Name:${student.name}',
                    style: ksize,
                  ),
                  Text(
                    'Roll no:${student.rollno}',
                    style: ksize,
                  ),
                  Text(
                    'Department:${student.department}',
                    style: ksize,
                  ),
                  Text(
                    'phone no:${student.phoneno}',
                    style: ksize,
                  ),
                  Text(
                    'Gender:${student.gender}',
                    style: ksize,
                  ),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (ctx) {
                                return EditScreen(
                                  student: student,
                                  id: id,
                                );
                              }));
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.black,
                              size: 25,
                            )),
                        IconButton(
                            onPressed: () {
                              Get.defaultDialog(
                                title: 'confirm Delete',
                                middleText: 'Are you sure you want to delete',
                                textCancel: "cancel",
                                textConfirm: 'confirm',
                                onCancel: () {
                                  return;
                                },
                                onConfirm: () {
                                  _studentController.deleteStudent(id);
                                  Get.back();
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.black,
                              size: 25,
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
