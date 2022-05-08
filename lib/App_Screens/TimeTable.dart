import 'package:flutter/material.dart';

import '../Reusable_Utils/AppBar.dart';

class TimeTable extends StatefulWidget {
  const TimeTable({Key? key}) : super(key: key);

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: "Today's Time Table"),
      body: const Center(
        child: Text('Time Table'),
      ),
    );
  }
}
