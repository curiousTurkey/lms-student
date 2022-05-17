
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lm_student/Reusable_Utils/snackBar.dart';

class ProfileUpdate{

  Future<String> updateAdmissionNumber({
    required String admissionNumber
  }) async {
    String finalResult = "Some error occurred";
    FirebaseAuth _auth = FirebaseAuth.instance;
    try{
      String _user = _auth.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_user)
          .update({"admissionNumber": admissionNumber});
      return finalResult = "success";
    } catch(error){
      finalResult = error.toString();
      return finalResult;
    }
  }
  Future<String> updateSemester({
    required String semName
  }) async {
    String finalResult = "Some error occurred";
    FirebaseAuth _auth = FirebaseAuth.instance;
    try{
      String _user = _auth.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_user)
          .update({"semester": semName});
      return finalResult = "success";
    } catch(error){
      finalResult = error.toString();
      return finalResult;
    }
  }//updateMethod

  Future<String> updateDepartment({
    required String deptName
  }) async {
    String finalResult = "Some error occurred";
    FirebaseAuth _auth = FirebaseAuth.instance;
    try{
      String _user = _auth.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_user)
          .update({"deptName": deptName});
      return finalResult = "success";
    } catch(error){
      finalResult = error.toString();
      return finalResult;
    }
  }

  Future<String> updateRegNo({
    required String regNo
  }) async {
    String finalResult = "Some error occurred";
    FirebaseAuth _auth = FirebaseAuth.instance;
    try{
      String _user = _auth.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_user)
          .update({"universityRegNo": regNo});
      return finalResult = "success";
    } catch(error){
      finalResult = error.toString();
      return finalResult;
    }
  }

  Future<String> updateMobile({
    required String mobileNumber
  }) async {
    String finalResult = "Some error occurred";
    FirebaseAuth _auth = FirebaseAuth.instance;
    try{
      String _user = _auth.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_user)
          .update({"mobileNumber": mobileNumber});
      return finalResult = "success";
    } catch(error){
      finalResult = error.toString();
      return finalResult;
    }
  }
  Future<String> updateImage({
  required imageUrl
}) async{
    String finalResult = "Couldn't update image. Check network or try again later";
    FirebaseAuth _auth = FirebaseAuth.instance;
    try{
      String _user = _auth.currentUser!.uid;
      await FirebaseFirestore.instance.collection('users').doc(_user).update(
          {'bio pic url' : imageUrl});
      return finalResult = "Image updated successfully.";
    }catch(error){
      finalResult = error.toString();
      return finalResult;
    }
}
} //class ProfileUpdate