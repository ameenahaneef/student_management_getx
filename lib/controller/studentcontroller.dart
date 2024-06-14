

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studentmanagementgetx/models/studentmodel.dart';

const String studentCollectionRef = "student";

class StudentController extends GetxController {
  final imageFile = ''.obs;
  String? _searchTxt;
  final _picker = ImagePicker();

  Future<void> selectImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = pickedFile.path.toString();
      update();
    }
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

  void updateStudent(String studentId, StudentModel studentModel) async {
    await _studentRef.doc(studentId).update(studentModel.tojson());
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
