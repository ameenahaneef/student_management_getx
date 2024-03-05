import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studentmanagementgetx/models/studentmodel.dart';

const String studentCollectionRef = "student";

class StudentController extends GetxController {
  final Rx<File?> _imageFile = Rx<File?>(null);
  String? _searchTxt;
  final _picker = ImagePicker();
  Rx<File?> get imageFile => _imageFile;

  Future<void> setImageFileAsync(File imageFile) async {
    await Future.delayed(Duration.zero);
    _imageFile.value = imageFile;
    update();
  }

  Future<void> selectImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _imageFile.value = File(pickedFile.path);
      update();
    }
  }

  void clearImage() {
    _imageFile.value = File('');
    update();
  }

  final _fireStore = FirebaseFirestore.instance;
  late final CollectionReference<StudentModel> _studentRef;

  @override
  void onInit() {
    _studentRef =
        _fireStore.collection(studentCollectionRef).withConverter<StudentModel>(
              fromFirestore: (snapshots, _) =>
                  StudentModel.fromJson(snapshots.data()!),
              toFirestore: (student, _) => student.tojson(),
            );
    super.onInit();
  }

  void addStudent(StudentModel studentModel) async {
    _studentRef.add(studentModel);
    update();
  }

  Stream<QuerySnapshot> getStudents() {
    return _studentRef.snapshots();
  }

  void updateStudent(String studentId, StudentModel studentModel) {
    _studentRef.doc(studentId).update(studentModel.tojson());
    update();
  }

  void deleteStudent(String studentId) {
    _studentRef.doc(studentId).delete();
    Get.back();
    update();
  }


  Stream<QuerySnapshot> searchStudents(String searchTerm) {
    return _studentRef
        .where('name', isGreaterThanOrEqualTo: searchTerm)
        .where('name', isLessThan: '${searchTerm}z')
        .snapshots();
  }

  String? get searchTxt => _searchTxt;

  void setSearchTxt(String? value) {
    _searchTxt = value;
    update();
  }
}

















//   void updateStudent(String studentId, StudentModel studentModel) async {
  //    _studentRef.doc(studentId).update(studentModel.tojson());
  //     int index = studentsList.indexWhere((s) => s.id == studentId);
  // if (index != -1) {
  //   studentsList[index] = studentModel;
  //   update();
  // }}
  // void getAllStudents() async {
//     final QuerySnapshot<StudentModel> snapshot = await _studentRef.get();
//     studentsList.assignAll(snapshot.docs.map((doc) => doc.data()).toList());
//     update();
//   }