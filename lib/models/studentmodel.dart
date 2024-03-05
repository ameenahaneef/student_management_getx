class StudentModel {
  String name;
  String rollno;
  String department;
  String phoneno;
  String gender;
  String imageUrl;
  StudentModel(
      {required this.name,
      required this.rollno,
      required this.department,
      required this.phoneno,
      required this.gender,
      required this.imageUrl
      });

  StudentModel.fromJson(Map<String, Object?> json)
      : this(
            name: json['name']! as String,
            rollno: json['rollno']! as String,
            department: json['department']! as String,
            phoneno: json['phoneno']! as String,
            gender: json['gender']! as String,
            imageUrl: json['imageUrl']! as String);

  String? get id => null;

  StudentModel copyWith(
      {String? name,
      String? rollno,
      String? department,
      String? phoneno,
      String? gender,
      String? imageUrl
      }) {
    return StudentModel(
        name: name ?? this.name,
        rollno: rollno ?? this.rollno,
        department: department ?? this.department,
        phoneno: phoneno ?? this.phoneno,
        gender: gender ?? this.gender,
        imageUrl: imageUrl ?? this.imageUrl
        );
  }

  Map<String, Object?> tojson() {
    return {
      'name': name,
      'rollno': rollno,
      'department': department,
      'phoneno': phoneno,
      'gender': gender,
      'imageUrl':imageUrl
    };
  }
}
