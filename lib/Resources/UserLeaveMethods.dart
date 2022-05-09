import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lm_student/Models/UserLeaveModel.dart';

class UserLeaveMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> applyLeave({
    required String fullName,
    required String dept,
    required String semester,
    required String email,
    required String leaveSubject,
    required String leaveReason,
    required String fromDate,
    required String toDate,
    required String session1,
    required String session2

}) async {
    String finalResult = "Database connection error. Check Network and try again";
    try {
      String _user = _auth.currentUser!.uid;
      UserLeaveModel userLeaveModel = UserLeaveModel(
          fullName: fullName,
          dept: dept,
          semester: semester,
          email: email,
          leaveSubject: leaveSubject,
          leaveReason: leaveReason,
          fromDate: fromDate,
          toDate: toDate,
          session1: session1,
          userId: _user,
          session2: session2);

      await _firestore.collection('student leave').doc().set(
          userLeaveModel.toJson());
      finalResult = "success";
      return finalResult;
    } catch(error){
      finalResult = error.toString();
      return finalResult;
    }

} //apply leave
} //class ending