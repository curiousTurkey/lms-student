import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lm_student/App_Screens/Login_page.dart';
import 'package:lm_student/App_Screens/Signup_page.dart';
import 'package:lm_student/Providers/UserProvider.dart';
import 'package:provider/provider.dart';
import 'App_Screens/Splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //portrait mode only
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'ArimaMadurai-Medium'),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.userChanges(),
            builder: (context,snapShot){
              if(snapShot.connectionState == ConnectionState.active){
                if(snapShot.hasData){
                  return const SplashScreen();
                }
               else if(snapShot.hasError){
                 return Scaffold(
                   body: Center(
                     child: Text('${snapShot.error}'),
                   ),
                 );
                }
              }
              if(snapShot.connectionState == ConnectionState.waiting){
                return const SplashScreen();
              }
              return const SplashScreen();
            },
          )
      ),
    );
  }
}