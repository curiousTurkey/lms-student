import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lm_student/App_Screens/Home_screen.dart';
import 'package:lm_student/App_Screens/MainPage.dart';
import 'package:lm_student/Models/User.dart';
import 'package:lm_student/Reusable_Utils/Colors.dart' as color_mode;
import 'package:lm_student/Reusable_Utils/Heightwidth.dart' as height_width;
import 'package:lm_student/Reusable_Utils/Responsive.dart' as resize;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lm_student/Reusable_Utils/Side_transition.dart';
import 'package:provider/provider.dart';
import '../Providers/UserProvider.dart';
import '../Reusable_Utils/CustomPageRoute.dart';
import 'Login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    addUserData();
    nextPage();
  }
  addUserData() async {
    UserProvider _userProvider = Provider.of(context,listen: false);
    await _userProvider.refreshUser();
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Widget nextPageWidget = const LoginScreen() ;
  void nextPage(){
    if(_auth.currentUser != null){
      setState(() {
        nextPageWidget = const MainPage();
      });
    }
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context, CustomPageRoute(child: nextPageWidget));
    });
  }
  String networkImage = "https://th.bing.com/th/id/R.79b825035f4e0c3ac28988c0a1ffbefb?rik=ql8k9UQNWt1nnQ&riu=http%3a%2f%2feyecarecahir.net%2fimages%2fbg2.png&ehk=jMDH3q8aZgyA214Qxq1BcAZBs7yOHokTyzRKA5UgeB8%3d&risl=&pid=ImgRaw&r=0";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
          image: DecorationImage(
            isAntiAlias: true,
            fit: BoxFit.contain,
            image: NetworkImage(networkImage),
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Center(
                  child: SpinKitRipple(
                    size: resize.screenLayout(350, context),
                    color: color_mode.secondaryColor,
                    borderWidth: resize.screenLayout(9, context),

                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: resize.screenLayout(75, context)),
                    child: Image.asset('assets/logos/graduate.png',
                      width: resize.screenLayout(200, context),
                    ),
                  ),
                ),
             ]
            ),
          ],
        ),
      ),
    );
  }
}
