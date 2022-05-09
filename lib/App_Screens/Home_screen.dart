import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lm_student/Models/User.dart';
import 'package:lm_student/Reusable_Utils/Colors.dart' as color_mode;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lm_student/App_Screens/Login_page.dart';
import 'package:lm_student/Resources/AuthMethods.dart';
import 'package:lm_student/Reusable_Utils/CustomPageRoute.dart';
import 'package:lm_student/Reusable_Utils/Heightwidth.dart' as height_width;
import 'package:lm_student/Reusable_Utils/Responsive.dart' as resize;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lm_student/Reusable_Utils/SideBar/SideBar.dart';
import 'package:provider/provider.dart';

import '../Providers/UserProvider.dart';
import '../Reusable_Utils/HeightWidth.dart';
import '../Reusable_Utils/HomeScreenContainer/HomeScreenContainer.dart';
import '../Reusable_Utils/PageView/PageView.dart';
import '../Reusable_Utils/Responsive.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState(){
    if(mounted) {
      super.initState();
    }
  }
  @override
  void dispose(){
    super.dispose();
  }
  void logoutUser() async{
    String finalResult = await AuthMethods().logoutUser();
    if(finalResult == "success"){
      Navigator.pushReplacement(context, CustomPageRoute(child: const LoginScreen()));
    }
  }
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserProvider>(context).getUser;
    return SafeArea(
      child: Scaffold(
        key: _globalKey,
        drawer: const SideBar(),
        backgroundColor: color_mode.primaryColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
                pinned: true,
                floating: false,
                snap: false,
                backgroundColor: color_mode.secondaryColor2,
                shadowColor: color_mode.tertiaryColor,
                elevation: 2,
                expandedHeight: getHeight(context) / 2.8,
                flexibleSpace: const FlexibleSpaceBar(
                  background: ScrollPageView(),
                )),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenLayout(30, context),
                    vertical: screenLayout(30, context)),
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: screenLayout(80, context),),
                          Padding(
                            padding: EdgeInsets.only(left: screenLayout(20, context)),
                            child: Text(
                              "All Services",
                              style: TextStyle(
                                  color: color_mode.tertiaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenLayout(40, context),
                                  letterSpacing: 1.5),
                            ),
                          ),
                          SizedBox(
                            height: screenLayout(40, context),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Wrap(
                              runSpacing: screenLayout(10, context),
                              spacing: screenLayout(10, context),
                              children: [
                                homeContainer(
                                    context: context,
                                    description: "Announcement from class teacher.",
                                    heading: "Announcement",
                                    icon: FontAwesomeIcons.bell,
                                    onTap: () {
                                     // Navigator.push(context, CustomPageRouteSide(child: const Announcement()));
                                    }),
                                homeContainer(
                                    context: context,
                                    description: "Announcement from department",
                                    heading: "Announcement",
                                    icon: FontAwesomeIcons.newspaper,
                                    onTap: () {}),
                                homeContainer(
                                    context: context,
                                    description: "View Timetable for the day",
                                    heading: "TimeTable",
                                    icon: FontAwesomeIcons.calendar,
                                    onTap: () {
                                     // Navigator.push(context, CustomPageRouteSide(child: const TimeTablePublish()));
                                    }),
                                homeContainer(
                                    context: context,
                                    description: "Apply for leave",
                                    heading: "Leave Application",
                                    icon: FontAwesomeIcons.paperPlane,
                                    onTap: () {
                                    //  Navigator.push(context, MaterialPageRoute(builder: (_) => const LeaveApply()));
                                    }),
                                homeContainer(
                                    context: context,
                                    description: "Status of leave",
                                    heading: "Leave Status",
                                    icon: FontAwesomeIcons.barsProgress,
                                    onTap: () {
                                    //  Navigator.push(context, MaterialPageRoute(builder: (_) => const LeaveStatus()));
                                    }),

                                homeContainer(
                                    context: context,
                                    description: "History of leave",
                                    heading: "Leave History",
                                    icon: FontAwesomeIcons.history,
                                    onTap: () {
                                     // Navigator.push(context, MaterialPageRoute(builder: (_) => const LeaveHistory()));
                                    }),

                              ],
                            ),
                          ),
                          SizedBox(height: screenLayout(100, context),),
                        ],
                      );
                    }, childCount: 1)),
          ],
        ),
      ),
    );
  }
}
