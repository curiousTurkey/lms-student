import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lm_student/Models/User.dart';
import 'package:lm_student/Models/UserLeaveModel.dart';
import 'package:lm_student/Providers/UserProvider.dart';
import 'package:provider/provider.dart';
import 'package:lm_student/Reusable_Utils/Colors.dart' as color_mode;
import 'package:lm_student/Reusable_Utils/Responsive.dart' as resize;
import '../Reusable_Utils/AppBar.dart';
import '../Reusable_Utils/HeightWidth.dart';
import '../Reusable_Utils/Responsive.dart';

class LeaveHistoryDetail extends StatefulWidget {
  final String docId;
  const LeaveHistoryDetail({
    Key? key,
    required this.docId,
  }) : super(key: key);

  @override
  State<LeaveHistoryDetail> createState() => _LeaveHistoryDetailState();
}

class _LeaveHistoryDetailState extends State<LeaveHistoryDetail> {
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      color: color_mode.secondaryColor,
      fontSize: resize.screenLayout(30, context),
      fontWeight: FontWeight.w800,
    );
    final Future<DocumentSnapshot<Map<String, dynamic>>> leaveDetails = FirebaseFirestore.instance.collection('student leave').doc(widget.docId).get();
    return Scaffold(
      appBar: appBar(context: context, title: 'Leave Details'),
      body : FutureBuilder(
          future: leaveDetails,
          builder: (_, AsyncSnapshot<DocumentSnapshot> snapshot){
            if (snapshot.hasError) {
              return const Text('Something went wrong. Try again later.');
            }
            else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: SpinKitFoldingCube(
                color: color_mode.secondaryColor,
                size: resize.screenLayout(80, context),
                duration: const Duration(milliseconds: 1500),
              ));
            }
            UserLeaveModel userLeaveModel = UserLeaveModel.fromJsonAsync(snapshot as AsyncSnapshot<DocumentSnapshot<Map<String , dynamic>>>);
            return SingleChildScrollView(
              child: Container(
                width: getWidth(context),
                height: getHeight(context),
                decoration: BoxDecoration(
                    color: color_mode.primaryColor
                ),
                child: Column(
                    children: [
                      resize.verticalSpace(80, context),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          resize.horizontalSpace(60, context),
                          Text('Name :',
                              style: textStyle),
                          resize.horizontalSpace(20, context),
                          Text(userLeaveModel.fullName,
                              style: textStyle
                          ),
                        ],
                      ),
                      resize.verticalSpace(50, context),
                      Row(
                        children: [
                          resize.horizontalSpace(60, context),
                          Text('E-mail : ',
                            style: textStyle,
                          ),
                          resize.horizontalSpace(20, context),
                          Text(userLeaveModel.email,
                            style: textStyle,)
                        ],
                      ),
                      resize.verticalSpace(50, context),
                      Row(
                        children: [
                          resize.horizontalSpace(60, context),
                          Text('Leave Subject : ',
                            style: textStyle,
                          ),
                          resize.horizontalSpace(20, context),
                          LimitedBox(
                            maxWidth: resize.screenLayout(240, context),
                            child: Text(userLeaveModel.leaveSubject,
                              style: textStyle,),
                          )
                        ],
                      ),
                      resize.verticalSpace(50, context),
                      Row(
                        children: [
                          resize.horizontalSpace(60, context),
                          Text('Leave Reason : ',
                            style: textStyle,
                          ),
                          resize.horizontalSpace(20, context),
                          LimitedBox(
                            maxWidth: resize.screenLayout(240, context),
                            child: Text(userLeaveModel.leaveReason,
                              style: textStyle,),
                          )
                        ],
                      ),
                      resize.verticalSpace(50, context),
                      Row(
                        children: [
                          resize.horizontalSpace(60, context),
                          Text('Department : ',
                            style: textStyle,
                          ),
                          resize.horizontalSpace(20, context),
                          Text(userLeaveModel.dept,
                            style: textStyle,)
                        ],
                      ),
                      resize.verticalSpace(50, context),
                      Row(
                        children: [
                          resize.horizontalSpace(60, context),
                          Text('From Date : ',
                            style: textStyle,
                          ),
                          resize.horizontalSpace(20, context),
                          Text(DateTime.parse(userLeaveModel.fromDate).toString(),
                            style: textStyle,)
                        ],
                      ),
                      resize.verticalSpace(50, context),
                      Row(
                        children: [
                          resize.horizontalSpace(60, context),
                          Text('To Date : ',
                            style: textStyle,
                          ),
                          resize.horizontalSpace(20, context),
                          Text(DateTime.parse(userLeaveModel.toDate).toString(),
                            style: textStyle,)
                        ],
                      ),
                      resize.verticalSpace(50, context),
                      Row(
                        children: [
                          resize.horizontalSpace(60, context),
                          Text('From Session : ',
                            style: textStyle,
                          ),
                          resize.horizontalSpace(20, context),
                          Text(userLeaveModel.session1,
                            style: textStyle,)
                        ],
                      ),
                      resize.verticalSpace(50, context),
                      Row(
                        children: [
                          resize.horizontalSpace(60, context),
                          Text('To Session : ',
                            style: textStyle,
                          ),
                          resize.horizontalSpace(20, context),
                          Text(userLeaveModel.session2,
                            style: textStyle,)
                        ],
                      ),
                      resize.verticalSpace(50, context),
                    ]
                ),
              ),
            );
          }),
    );
  }
}
