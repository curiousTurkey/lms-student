import 'package:flutter/material.dart';
import 'package:lm_student/Reusable_Utils/AppBar.dart';

class LeaveApplication extends StatefulWidget {
  const LeaveApplication({Key? key}) : super(key: key);

  @override
  State<LeaveApplication> createState() => _LeaveApplicationState();
}

class _LeaveApplicationState extends State<LeaveApplication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Leave Application'),
      body: const Center(child: Text('Leave Application'),),
    );
  }
}
