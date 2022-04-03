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
    return Scaffold(
      key: _globalKey,
      drawer: const SideBar(),
      backgroundColor: color_mode.primaryColor,
      body: Stack(
        children: [
          IconButton(
            icon: const Icon(Icons.menu_rounded),
            onPressed: () {
              _globalKey.currentState?.openDrawer();
            },),
          Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text("Welcome " + userModel.fullName)),
            FloatingActionButton(onPressed: logoutUser,child: const Text('Logout'),),
          ],
        ),
      ]
      ),
    );
  }
}
