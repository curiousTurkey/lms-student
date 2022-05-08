import 'package:flutter/material.dart';
import 'package:lm_student/Reusable_Utils/AppBar.dart';
class DeptAnnounce extends StatefulWidget {
  const DeptAnnounce({Key? key}) : super(key: key);

  @override
  State<DeptAnnounce> createState() => _DeptAnnounceState();
}

class _DeptAnnounceState extends State<DeptAnnounce> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Department Announcement'),
      body: const Center(
        child: Text('Department Announcement'),
      ),
    );
  }
}
