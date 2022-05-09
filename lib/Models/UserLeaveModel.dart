import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserLeaveModel {
  final String fullName;
  final String dept;
  final String semester;
  final String email;
  final String leaveSubject;
  final String leaveReason;
  final String fromDate;
  final String toDate;
  final String session1;
  final String session2;
  final String userId;
  String isApproved;

  //class constructor

  UserLeaveModel({
    required this.userId,
    required this.fullName,
    required this.dept,
    required this.semester,
    required this.email,
    required this.leaveSubject,
    required this.leaveReason,
    required this.fromDate,
    required this.toDate,
    required this.session1,
    required this.session2,
    this.isApproved = "no"
  });

  Map<String, dynamic> toJson() =>
      {
        'name': fullName,
        'deptName': dept,
        'semester': semester,
        'email': email,
        'leavesub': leaveSubject,
        'leavereason': leaveReason,
        'fromdate': fromDate,
        'todate': toDate,
        'session1': session1,
        'session2': session2,
        'isapproved': isApproved,
        'userid' : userId
      };

  static UserLeaveModel fromSnap(DocumentSnapshot snapshot) {
    var snapShot = snapshot.data() as Map<String, dynamic>;
    return UserLeaveModel(
        fullName: snapShot['name'],
        dept: snapShot['deptName'],
        semester: snapShot['semester'],
        email: snapShot['email'],
        leaveSubject: snapShot['leavesub'],
        leaveReason: snapShot['leavereason'],
        fromDate: snapShot['fromdate'],
        toDate: snapShot['todate'],
        session1: snapShot['session1'],
        session2: snapShot['session2'],
        isApproved: snapShot['isapproved'],
      userId: snapShot['userid']
    );
  }

  static UserLeaveModel fromJsonAsync(
      AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> json) =>
      UserLeaveModel(
        userId: json.data!['userid'],
          fullName: json.data!['name'],
          dept: json.data!['deptName'],
          semester: json.data!['semester'],
          email: json.data!['email'],
          leaveSubject: json.data!['leavesub'],
          leaveReason: json.data!['leavereason'],
          fromDate: json.data!['fromdate'],
          toDate: json.data!['todate'],
          session1: json.data!['session1'],
          session2: json.data!['session2'],
          isApproved: json.data!['isapproved']
      );

}