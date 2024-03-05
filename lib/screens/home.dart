import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:studentmanagementgetx/constants/constant.dart';
import 'package:studentmanagementgetx/controller/studentcontroller.dart';
import 'package:studentmanagementgetx/models/studentmodel.dart';
import 'package:studentmanagementgetx/screens/studentlist.dart';

class HomeScreen extends StatelessWidget {
  final StudentController _studentController = Get.put(StudentController());
  HomeScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController rollNumberController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          'Add Student',
        ),
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
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    _studentController.selectImageFromGallery();
                  },
                  child: Obx(() {
                    return CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius: 70,
                      backgroundImage:
                          _studentController.imageFile.value != null &&
                                  _studentController
                                      .imageFile.value!.path.isNotEmpty
                              ? FileImage(_studentController.imageFile.value!)
                              : null,
                      child: _studentController.imageFile.value == null ||
                              _studentController.imageFile.value!.path.isEmpty
                          ? const Icon(
                              Icons.camera_alt,
                              size: 40,
                              color: kWhite,
                            )
                          : null,
                    );
                  }),
                ),
                kHeight,
                textformfield('Name', nameController),
                kHeight,
                textformfield('Roll Number', rollNumberController,
                    keyBoardType: TextInputType.number),
                kHeight,
                textformfield('Department', departmentController),
                kHeight,
                textformfield('PhoneNumber', phoneNumberController,
                    keyBoardType: TextInputType.phone),
                kHeight,
                textformfield('Gender', genderController),
                kHeight,
                SizedBox(
                    width: 250,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            _studentController.imageFile.value != null) {
                          _studentController.addStudent(StudentModel(
                            name: nameController.text,
                            rollno: rollNumberController.text,
                            department: departmentController.text,
                            phoneno: phoneNumberController.text,
                            gender: genderController.text,
                            imageUrl: _studentController.imageFile.value!.path,
                          ));

                          nameController.clear();
                          rollNumberController.clear();
                          departmentController.clear();
                          phoneNumberController.clear();
                          genderController.clear();
                          _studentController.clearImage();
                          
                          Get.snackbar('Added', 'Added successfully',backgroundColor: Colors.green,colorText: Colors.white);
                        } else {
                         
                          Get.snackbar('', 'please fill all fields',backgroundColor: Colors.red,colorText: kWhite);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                      ),
                      child: const Text(
                        'Add Student',
                        style: kStyle,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField textformfield(String label, TextEditingController controller,
          {TextInputType? keyBoardType}) =>
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
        keyboardType: keyBoardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a $label';
          }
          return null;
        },
      );
}
