import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lm_student/Models/User.dart';
import 'package:lm_student/Resources/Storage_method.dart';



//class to define Auth Methods

class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int duration = 2000;

  Future<UserModel> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snapshot = await _firestore.collection('users').doc(currentUser.uid).get();
    return UserModel.fromSnap(snapshot);
  }

  //Sign Up function

  Future<String> signupUser({
    required String fullName,
    required String emailAddress,
    required String password,
    required File profileImage,
    required String semester
}) async{

    String finalResult = "Error 500. Database Connection Failed";
    try{

      // create user
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: emailAddress, password: password);
      //storing profile picture
      String imageUrl = await StorageMethods().uploadImageToStorage('profilepicture', profileImage);
      var userId = userCredential.user!.uid;
      //add user to firebase firestore database
      UserModel userModel = UserModel(
          imageUrl: imageUrl,
          emailAddress: emailAddress,
          fullName: fullName,
          userId: userId,
        courseType: 'Under Graduate',
        admissionNumber: 'null',
        deptName: 'null',
        mobileNumber: 'null',
        batch: semester,
        universityRegNo: 'null',
      );
      await _firestore.collection('users').doc(userId).set(userModel.toJson());
      finalResult = "success";
    }on FirebaseAuthException catch(error){
      if(error.code == 'invalid-email') {
        finalResult = 'Provide a valid E-mail';
      }
      else if(error.code == 'weak-password'){
        finalResult = 'Provide a strong password. (Min 6 characters)';
      }
      else if(error.code == 'user-not-found'){
        finalResult = 'User not registered. Please register or check credentials';
      }
      else if(error.code == 'email-already-in-use'){
        finalResult = "The email address is already in use by another account.";
      }
    } //catch block
    return finalResult;
    }

  //login function
  Future<String> loginUser({
    required String emailAddress,
    required String password,
    required String userType
}) async {
    String finalResult = "Error 500. Internal Error. Check network or try again later";
    try{
      if(emailAddress.isNotEmpty || password.isNotEmpty){
       UserCredential _userCredential =  await _auth.signInWithEmailAndPassword(email: emailAddress, password: password);
       var userId = _userCredential.user!.uid;
       DocumentSnapshot snapshot = await _firestore.collection('users').doc(userId).get();
       var userType = ((snapshot.data() as Map<String, dynamic>)['usertype']);
       if(userType == 'student'){
         finalResult = "success";
       }
       else{
         finalResult = "User not found. Check credentials";
         logoutUser();
       }
       return finalResult;
      }
      else {
        return finalResult;
      }
    } on FirebaseAuthException catch(error){
      if(error.code == 'invalid-email') {
        finalResult = 'Please provide a valid email';
      }
      else if(error.code == 'weak-password'){
        finalResult = 'Provide a valid password. (Min 6 characters)';
      }
      else if(error.code == 'user-not-found'){
        finalResult = 'User not registered. Please register or check credentials';
      }
      else if(error.code == 'wrong-password'){
        finalResult = 'Wrong credentials. Check password';
      }
      else {
        finalResult = error.toString();
        return finalResult;
      }
      return finalResult;
    }
} //login function
Future<String> logoutUser() async {
    String finalResult = "";
    try {
      _auth.signOut();
      finalResult = "success";
      return finalResult;
    } on FirebaseAuthException catch(error){
      return error.toString();
    }
}
  } // class ending