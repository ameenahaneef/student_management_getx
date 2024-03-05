import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:studentmanagementgetx/constants/constant.dart';
import 'package:studentmanagementgetx/controller/studentcontroller.dart';
import 'package:studentmanagementgetx/models/studentmodel.dart';
import 'package:studentmanagementgetx/screens/studentlist.dart';

class EditScreen extends StatelessWidget {
final StudentModel student;
final String id;

  EditScreen({
    super.key,
     required this.student, required this.id,
   
  });
   final StudentController _studentController = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController(text: student.name);
  final TextEditingController rollNumberController = TextEditingController(text: student.rollno);
  final TextEditingController departmentController = TextEditingController(text: student.department);
  final TextEditingController phoneNumberController = TextEditingController(text: student.phoneno);
  final TextEditingController genderController = TextEditingController(text: student.gender);
   
  
   _studentController.imageFile.value=File(student.imageUrl);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: const Text('Edit Screen'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return StudentList();
                  }));
                },
                icon: const Icon(
                  Icons.person,
                ))
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                    child: Column(children: [
                  GestureDetector(
                    onTap: () {
                   _studentController.selectImageFromGallery();
                    },
                    child: Obx((){
                    return CircleAvatar(
                        backgroundColor: Colors.amber,
                        radius: 70,
                        backgroundImage: _studentController.imageFile.value!=null
                            ? FileImage(_studentController.imageFile.value!)
                            : null,
                        child: _studentController.imageFile.value==null ? 
                         const Icon(
                                Icons.camera_alt,
                                size: 40,
                                color: kWhite,
                              )
                            : null
                      );
  }),
                  ),
                  kHeight,
                  textformfield('Name', nameController),
                  kHeight,
                  textformfield('Roll Number', rollNumberController),
                  kHeight,
                  textformfield('Department', departmentController),
                  kHeight,
                  textformfield('PhoneNumber', phoneNumberController),
                  kHeight,
                  textformfield('Gender', genderController),
                  kHeight,
                  SizedBox(
                      width: 250,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber),
                          onPressed: () {
                            if (_formKey.currentState!.validate() &&
                               _studentController.imageFile.value!=null) {
                              StudentModel updatedStudent = student.copyWith(
                                name: nameController.text,
                                rollno: rollNumberController.text,
                                department: departmentController.text,
                                phoneno: phoneNumberController.text,
                                gender: genderController.text,
                                imageUrl: _studentController.imageFile.value!.path,
                              );

                              _studentController.updateStudent(id, updatedStudent);
                              Get.snackbar('success', 'Changes saved');
                               
                            Get.off(StudentList());
                               

                            }
                          },
                          child: const Text(
                            'Save Changes',
                            style: kStyle,
                          )))
                ])))));
  }

  TextFormField textformfield(String label, TextEditingController controller) =>
      TextFormField(
          controller: controller,
          style: const TextStyle(color: kBlack, fontSize: 20),
          decoration: InputDecoration(
              label: Text(
                label,
                style: const TextStyle(color: Colors.black),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.black, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide:
                      const BorderSide(color: Colors.deepOrange, width: 2.5)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide:
                      const BorderSide(color: Colors.deepOrange, width: 2.5)),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide:
                    const BorderSide(color: Colors.deepOrange, width: 2.5),
              ),
              errorStyle: const TextStyle(color: kDeepOrange, fontSize: 15)),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a $label';
            }
            return null;
          });
}
