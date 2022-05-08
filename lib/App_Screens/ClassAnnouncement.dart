import 'package:flutter/material.dart';
import 'package:lm_student/Reusable_Utils/AppBar.dart';

class ClassAnnouncement extends StatefulWidget {
  const ClassAnnouncement({Key? key}) : super(key: key);

  @override
  State<ClassAnnouncement> createState() => _ClassAnnouncementState();
}

class _ClassAnnouncementState extends State<ClassAnnouncement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Class Announcement'),
      body: const Center(
        child: Text('Class Announcement'),
      ),
    );
  }
}
