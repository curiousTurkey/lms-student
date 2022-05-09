
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:lm_student/App_Screens/Home_screen.dart';
import 'package:lm_student/App_Screens/ResetPassword.dart';
import 'package:lm_student/App_Screens/Signup_page.dart';
import 'package:lm_student/Resources/AuthMethods.dart';
import 'package:lm_student/Reusable_Utils/CustomPageRoute.dart';
import 'package:lm_student/Reusable_Utils/Heightwidth.dart' as height_width;
import 'package:lm_student/Reusable_Utils/Colors.dart' as color_mode;
import 'package:lm_student/Reusable_Utils/Responsive.dart' as resize;
import 'package:lm_student/Reusable_Utils/Side_transition.dart';
import 'package:lm_student/Reusable_Utils/TextFormField.dart';
import 'package:lm_student/Reusable_Utils/Button.dart';
import 'package:lm_student/Reusable_Utils/alertDialogprofile.dart';
import 'package:lm_student/Reusable_Utils/snackBar.dart';

import 'MainPage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  int duration = 2000;
  void loginUser() async {
    setState(() {
      isLoading = true;
    });
    String finalResult = await AuthMethods().loginUser(emailAddress: _emailController.text, password: _passwordController.text, userType: 'student');
    if(finalResult == 'success'){
      Navigator.pushReplacement(context, CustomPageRoute(child: const MainPage()));
    }
    else{
      snackBar(content: finalResult, duration: duration, context: context);
    }
    setState(() {
      isLoading = false;
    });
  }
  @override
  void initState(){
    if(mounted){
      super.initState();
    }
  }
  @override
  void dispose(){
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              height: height_width.getHeight(context),
              width: height_width.getWidth(context),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color_mode.primaryColor,color_mode.primaryColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Container(
              height: height_width.getHeight(context),
              child: SingleChildScrollView(
                physics: (MediaQuery.of(context).viewInsets.bottom!=0) ? const AlwaysScrollableScrollPhysics() : const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: resize.screenLayout(50, context),vertical: resize.screenLayout(60, context)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: resize.screenLayout(40, context),),
                    CircleAvatar(
                      radius: resize.screenLayout(70, context),
                      backgroundImage: const AssetImage('assets/logos/graduate.png'),
                    ),
                    SizedBox(height: resize.screenLayout(40, context),),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextForm(
                            textEditingController: _emailController,
                            prefixIcon: const Icon(Icons.person_pin),
                            textInputType: TextInputType.emailAddress,
                            hintText: 'example@mail.com',
                            labelText: 'E-mail',
                          isEmail: true,
                        ),
                        SizedBox(height: resize.screenLayout(70, context),),
                        TextForm(
                          textEditingController: _passwordController,
                          prefixIcon: const Icon(Icons.lock_sharp),
                          textInputType: TextInputType.visiblePassword,
                          isPass: true,
                          hintText: 'Minimum 6 characters',
                          labelText: 'Password',
                        ),
                        SizedBox(height: resize.screenLayout(40, context),),
                        Container(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const ResetPassword()));
                            },
                            child: Text('Forgot password?',
                              style: TextStyle(
                                fontSize: resize.screenLayout(28, context),
                                fontWeight: FontWeight.w600,
                                color: color_mode.tertiaryColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: resize.screenLayout(10, context),),
                        Container(
                                padding: EdgeInsets.symmetric(vertical: resize.screenLayout(25, context)),
                                width: double.infinity,
                          child: FloatingActionButton(
                            onPressed: () {
                             if(_emailController.text.isNotEmpty || _passwordController.text.isNotEmpty){
                               loginUser();
                             }
                             else{
                               snackBar(content: 'Please provide all fields.', duration: duration, context: context);
                             }
                            },
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(resize.screenLayout(25, context)),
                            ),
                            backgroundColor: color_mode.secondaryColor,
                            enableFeedback: true,
                            child: (isLoading==false)?Text('Log In',
                              style: TextStyle(
                                fontSize: resize.screenLayout(26, context),
                                fontWeight: FontWeight.w500,
                              ),
                            ):SpinKitCircle(
                              color: color_mode.primaryColor,
                              size: resize.screenLayout(50, context),

                            ),
                          ),
                        ),
                        SizedBox(height: resize.screenLayout(40, context),),
                        Row(
                          children: [
                            Text("Don't have Account?",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: color_mode.secondaryColor,
                              fontSize: resize.screenLayout(26, context)
                            ),
                            ),
                            SizedBox(width: resize.screenLayout(10, context),),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context,CustomPageRouteSide(child: const SignupScreen()));
                              },
                              child: Text('Sign Up',
                                style: TextStyle(
                                  fontSize: resize.screenLayout(28, context),
                                  fontWeight: FontWeight.w700,
                                  color: color_mode.spclColor2
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
