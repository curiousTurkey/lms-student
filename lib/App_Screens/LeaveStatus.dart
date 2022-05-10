import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lm_student/Models/User.dart';
import 'package:lm_student/Providers/UserProvider.dart';
import '../Reusable_Utils/AppBar.dart';
import 'package:lm_student/Reusable_Utils/Colors.dart' as color_mode;
import 'package:lm_student/Reusable_Utils/Responsive.dart' as resize;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Reusable_Utils/Responsive.dart';

class LeaveStatus extends StatefulWidget {
  const LeaveStatus({Key? key}) : super(key: key);

  @override
  State<LeaveStatus> createState() => _LeaveStatusState();
}

class _LeaveStatusState extends State<LeaveStatus> {
  String approveStatus = '';
  @override
  Widget build(BuildContext context) {
    TextStyle rejectStyle = TextStyle(
      color: Colors.red,
      fontWeight: FontWeight.w600,
      fontSize: screenLayout(28, context),
    );
    TextStyle pendingStyle = TextStyle(
      color: Colors.orangeAccent,
      fontWeight: FontWeight.w600,
      fontSize: screenLayout(28, context),
    );
    TextStyle approvedStyle = TextStyle(
      color: Colors.green,
      fontWeight: FontWeight.w600,
      fontSize: screenLayout(28, context),
    );
    TextStyle activeStyle ;
    DateTime todayDate = DateTime.now();
    var formatDate = DateFormat('d-MM-yyyy');
    String formattedDate = formatDate.format(todayDate);
    UserModel userModel = Provider.of<UserProvider>(context).getUser;
    String email = userModel.emailAddress;
    final Stream<QuerySnapshot> leavelist = FirebaseFirestore.instance.collection('student leave').
    where('email', isEqualTo: email).where('fromdate', isGreaterThanOrEqualTo: formattedDate).orderBy('fromdate',descending: true).snapshots();
    return Scaffold(
      appBar: appBar(context: context, title: 'Leave Status'),
      body: StreamBuilder<QuerySnapshot>(
        stream: leavelist,
        builder: (_, AsyncSnapshot<QuerySnapshot> snapshot){
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
          int itemCount = snapshot.data!.size;
          return ListView.builder(
              itemCount: itemCount,
              itemBuilder: (_, int index){
                String name = snapshot.data!.docs[index]['name'];
                String subject = snapshot.data!.docs[index]['leavesub'];
                String reason = snapshot.data!.docs[index]['leavereason'];
                String approve = snapshot.data!.docs[index]['isapproved'];
                if(approve == 'yes') {
                  approveStatus = "Approved";
                  activeStyle = approvedStyle;
                }
                else if(approve == 'no'){
                  approveStatus = "Pending";
                  activeStyle = pendingStyle;
                }
                else {
                  approveStatus = 'Rejected';
                  activeStyle = rejectStyle;
                }
                return ListTile(
                  minVerticalPadding: resize.screenLayout(50, context),
                  title: Text(subject),
                  leading: (userModel.imageUrl == "null") ? Initicon(
                    borderRadius: BorderRadius.circular(
                        screenLayout(10, context)),
                    text: name,
                    size: resize.screenLayout(90, context),
                    elevation: 5,
                  ) : Image.network(userModel.imageUrl,
                    width: resize.screenLayout(90, context),
                    height: resize.screenLayout(100, context),),
                  trailing: Padding(
                    padding: const EdgeInsets.only(top: 14.0),
                    child: Text(
                      approveStatus,
                      style: activeStyle,
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
