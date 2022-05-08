import 'package:flutter/material.dart';

import '../Reusable_Utils/AppBar.dart';

class LeaveHistoryDetail extends StatefulWidget {
  const LeaveHistoryDetail({Key? key}) : super(key: key);

  @override
  State<LeaveHistoryDetail> createState() => _LeaveHistoryDetailState();
}

class _LeaveHistoryDetailState extends State<LeaveHistoryDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Leave Details'),
      body: const Center(
        child: Text('Leave Details'),
      ),
    );
  }
}
