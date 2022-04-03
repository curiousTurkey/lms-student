import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lm_student/Models/User.dart';
import 'package:lm_student/Resources/AuthMethods.dart';
import 'package:provider/provider.dart';

class UserProvider with ChangeNotifier{
  UserModel _user = UserModel(
      imageUrl: '',
      emailAddress: '',
      fullName: '',
      userId: '',
      mobileNumber: '',
      profileCompleted: false,
      courseType: '',
      admissionNumber: '',
      universityRegNo: '',
      batch: '',
      deptName: ''
  );
  final AuthMethods _authMethods = AuthMethods();

  UserModel get getUser => _user;

  Future<void> refreshUser() async {
    UserModel user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}