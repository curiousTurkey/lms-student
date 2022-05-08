
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel{
  final String fullName;
  final String emailAddress;
  final String imageUrl;
  final String userId;
  late String deptName;
  late String batch;
  late String universityRegNo;
  late String admissionNumber;
  late String courseType;
  late String mobileNumber;
  final String userType;

  bool profileCompleted = false;
   UserModel({
    required this.imageUrl,
    required this.emailAddress,
    required this.fullName,
    required this.userId,
     this.profileCompleted = false,
     required this.universityRegNo,
     required this.deptName ,
     required this.batch ,
     required this.admissionNumber,
     required this.courseType,
     required this.mobileNumber,
     this.userType = "student"

});
Map<String , dynamic> toJson() => {
  "name" : fullName,
  "email" : emailAddress,
  "bio pic url" : imageUrl,
  "user id" : userId,
  "profileCompleted" : profileCompleted,
  "universityRegNo" : universityRegNo,
  "deptName" : deptName,
  "admissionNumber" : admissionNumber,
  "semester" : batch,
  "courseType" : courseType,
  "mobileNumber" : mobileNumber,
  "usertype" : userType,

  };

  static UserModel fromSnap(DocumentSnapshot snapshot){
    var snapShot = snapshot.data() as Map<String,dynamic>;
    return UserModel(
        imageUrl: snapShot['bio pic url'],
        emailAddress: snapShot['email'],
        fullName: snapShot['name'],
        userId: snapShot['user id'],
      profileCompleted: snapShot['profileCompleted'],
      deptName: snapShot['deptName'],
      universityRegNo: snapShot['universityRegNo'],
      batch: snapShot['semester'],
      admissionNumber: snapShot['admissionNumber'],
      courseType: snapShot['courseType'],
      mobileNumber: snapShot['mobileNumber'],
      userType: snapShot['usertype'],
    );
  }
}