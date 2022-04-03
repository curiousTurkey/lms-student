import 'package:flutter/material.dart';
import 'package:lm_student/App_Screens/MainPage.dart';
import 'package:lm_student/App_Screens/ProfileScreen.dart';
import 'package:lm_student/Models/User.dart';
import 'package:lm_student/Providers/UserProvider.dart';
import 'package:lm_student/Reusable_Utils/Responsive.dart';
import 'package:provider/provider.dart';
import 'package:lm_student/Reusable_Utils/Colors.dart' as color_mode;

import '../../App_Screens/Login_page.dart';
import '../../Resources/AuthMethods.dart';
import '../CustomPageRoute.dart';
class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  void logoutUser() async{
    String finalResult = await AuthMethods().logoutUser();
    if(finalResult == "success"){
      Navigator.pushReplacement(context, CustomPageRoute(child: const LoginScreen()));
    }
  }
  @override
  Widget build(BuildContext context) {
    final UserModel _userModel = Provider
        .of<UserProvider>(context)
        .getUser;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: screenLayout(340, context),
            child: UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                    image:  DecorationImage(
                        image: AssetImage('assets/Background/1092608.webp'),
                        fit: BoxFit.cover,
                        isAntiAlias: true,
                        filterQuality: FilterQuality.high
                    )
                ),
                accountName: Text(_userModel.fullName,
                  style: TextStyle(color: color_mode.primaryColor,
                      fontWeight: FontWeight.bold
                  ),
                ),
                accountEmail: Text(_userModel.emailAddress,
                  style: TextStyle(color: color_mode.primaryColor,
                      fontWeight: FontWeight.bold
                  ),
                ),
                currentAccountPicture: InkWell(
                  splashColor: color_mode.secondaryColor,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const ProfileScreen()));
                  },
                  child: CircleAvatar(
                    radius: screenLayout(120, context),
                    backgroundImage: NetworkImage(_userModel.imageUrl),
                  ),
                )
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home_outlined, color: color_mode.secondaryColor,),
            title: const Text('Home'),
            textColor: color_mode.tertiaryColor,
            trailing: Icon(Icons.arrow_forward_ios_rounded,
              color: color_mode.tertiaryColor,),
            enableFeedback: true,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const MainPage()));
            },

          ),
          ListTile(
            leading: Icon(
              Icons.announcement_outlined, color: color_mode.secondaryColor,),
            title: const Text('Announcements'),
            textColor: color_mode.tertiaryColor,
            trailing: Icon(Icons.arrow_forward_ios_rounded,
              color: color_mode.tertiaryColor,),
            enableFeedback: true,
            onTap: () {
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout_outlined, color: color_mode.secondaryColor,),
            title: const Text('Logout'),
            textColor: color_mode.tertiaryColor,
            trailing: Icon(Icons.arrow_forward_ios_rounded,
              color: color_mode.tertiaryColor,),
            onTap: logoutUser

          ),

        ],
      ),
    );
  }
}


