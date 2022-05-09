import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lm_student/App_Screens/LeaveHistoryDetail.dart';
import 'package:lm_student/Models/User.dart';
import 'package:lm_student/Models/UserLeaveModel.dart';
import 'package:lm_student/Providers/UserProvider.dart';
import 'package:provider/provider.dart';
import 'package:lm_student/Reusable_Utils/Colors.dart' as color_mode;
import 'package:lm_student/Reusable_Utils/Responsive.dart' as resize;
import '../Reusable_Utils/AppBar.dart';
import '../Reusable_Utils/Responsive.dart';

class LeaveHistory extends StatefulWidget {
  const LeaveHistory({Key? key}) : super(key: key);

  @override
  State<LeaveHistory> createState() => _LeaveHistoryState();
}

class _LeaveHistoryState extends State<LeaveHistory> {
  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserProvider>(context).getUser;
    final Stream<QuerySnapshot> leaveList = FirebaseFirestore.instance.collection('student leave').where('email', isEqualTo: userModel.emailAddress).
    where('isapproved' , isEqualTo: 'yes').snapshots();
    return Scaffold(
      appBar: appBar(context: context, title: 'Leave History'),
      body: StreamBuilder<QuerySnapshot>(
        stream: leaveList,
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
                String docId = snapshot.data!.docs[index].id;
                String name = snapshot.data!.docs[index]['name'];
                String subject = snapshot.data!.docs[index]['leavesub'];
                String reason = snapshot.data!.docs[index]['leavereason'];
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
                  trailing: TextButton(
                      style: TextButton.styleFrom(
                        enableFeedback: true,
                      ),
                      onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => LeaveHistoryDetail(docId: docId)));
                      },
                      child: Text('Show Details',
                        style: TextStyle(color: color_mode.secondaryColor),
                      )),
                );
              });
        },
      ),
    );
  }
}
