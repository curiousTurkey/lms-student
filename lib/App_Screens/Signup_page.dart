
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lm_student/App_Screens/Home_screen.dart';
import 'package:lm_student/App_Screens/Login_page.dart';
import 'package:lm_student/Resources/AuthMethods.dart';
import 'package:lm_student/Reusable_Utils/Heightwidth.dart' as height_width;
import 'package:lm_student/Reusable_Utils/Colors.dart' as color_mode;
import 'package:lm_student/Reusable_Utils/Responsive.dart' as resize;
import 'package:lm_student/Reusable_Utils/Side_transition.dart';
import 'package:lm_student/Reusable_Utils/TextFormField.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lm_student/Reusable_Utils/snackBar.dart';
import 'dart:io';

import '../Reusable_Utils/Button.dart';
import 'MainPage.dart';
class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  File? imageSelected;
  late String _selected;
  bool isLoading = false;
  int duration = 3000;
  @override
  void dispose(){
    super.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }
  void selectImageGallery() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    File file = File(image!.path); //converting XFile as File
    setState(() {
      imageSelected = file;
    });
  }
  void selectImageCamera() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    File file = File(image!.path);
    setState(() {
      imageSelected = file;
    });
  }
  _displayDialog(BuildContext context) async {
    _selected = await showDialog(
      barrierColor: color_mode.secondaryColor,
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('Choose Location',
              style: TextStyle(
                color: color_mode.tertiaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              SimpleDialogOption(
                onPressed: (){
                  selectImageCamera();
                  Navigator.pop(context);
                },
                child: Text('Camera',
                  style: TextStyle(
                    color: color_mode.secondaryColor,
                    fontWeight: FontWeight.w500,
                      backgroundColor: color_mode.primaryColor
                  ),
                ),
              ),
              SizedBox(height: resize.screenLayout(20, context),),
              SimpleDialogOption(
                onPressed: (){
                  selectImageGallery();
                  Navigator.pop(context);
                },
                child: Text('Gallery',
                  style: TextStyle(
                    color: color_mode.secondaryColor,
                    fontWeight: FontWeight.w500,
                    backgroundColor: color_mode.primaryColor
                  ),
                ),
              ),
            ],
          );
        });
  }
  void signupUser() async {
    setState(() {
      isLoading = true;
    });
    String finalResult = await AuthMethods().signupUser(
        fullName: _fullNameController.text,
        emailAddress: _emailController.text,
        password: _passwordController.text,
        profileImage: imageSelected!);
    setState(() {
      isLoading = false;
    });
    if(finalResult == 'success'){
     Navigator.pushReplacement(context, CustomPageRouteSide(child: const MainPage()));
    }
    else{
      snackBar(content: finalResult, duration: duration, context: context);
    }
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          height: height_width.getHeight(context),
          width: height_width.getWidth(context),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color_mode.primaryColor,color_mode.primaryColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
            ),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: resize.screenLayout(50, context),vertical: resize.screenLayout(80, context)),
            physics: (MediaQuery.of(context).viewInsets.bottom!=0) ? const AlwaysScrollableScrollPhysics() : const NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children :[
                    (imageSelected != null)? 
                        GestureDetector(
                          onTap: (){_displayDialog(context);},
                          child: CircleAvatar(
                            maxRadius: resize.screenLayout(80, context),
                            backgroundImage: FileImage(imageSelected!),
                            backgroundColor: Colors.white70,
                          ),
                        )
                        : 
                    GestureDetector(
                      onTap: (){_displayDialog(context);},
                      child: CircleAvatar(
                        maxRadius: resize.screenLayout(80, context),
                        backgroundColor: Colors.white70,
                        backgroundImage: const AssetImage('assets/logos/graduate.png'),
                      ),
                    ),

                  ],
                ),
                SizedBox(height: resize.screenLayout(40, context),),
                TextForm(
                    textEditingController: _fullNameController,
                    prefixIcon: const Icon(Icons.person_pin),
                    textInputType: TextInputType.name,
                    labelText: 'Name',
                    hintText: 'Full name'),
                SizedBox(height: resize.screenLayout(30, context),),
                TextForm(
                    textEditingController: _emailController,
                    prefixIcon: const Icon(Icons.alternate_email_outlined),
                    textInputType: TextInputType.emailAddress,
                    labelText: 'E-mail',
                    hintText: 'example@mail.com'),
                SizedBox(height: resize.screenLayout(30, context),),
                TextForm(
                    textEditingController: _passwordController,
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    textInputType: TextInputType.visiblePassword,
                    labelText: 'Password',
                    hintText: 'Min 6 characters',
                    isPass: true),
                SizedBox(height: resize.screenLayout(30, context),),
                TextForm(
                    textEditingController: _confirmPasswordController,
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    textInputType: TextInputType.visiblePassword,
                    labelText: 'Confirm Password',
                    hintText: 'Min 6 characters',
                    isPass: true,
                ),
                SizedBox(height: resize.screenLayout(30, context),),
                Container(
                  padding: EdgeInsets.symmetric(vertical: resize.screenLayout(25, context)),
                  width: double.infinity,
                  child: FloatingActionButton(
                    onPressed: () {
                      if(_emailController.text.isEmpty||
                          _fullNameController.text.isEmpty||
                          _passwordController.text.isEmpty||
                          _confirmPasswordController.text.isEmpty
                      ){
                        snackBar(content: 'Please provide all fields.', duration: duration, context: context);
                      }else if(imageSelected==null){
                        snackBar(content: 'Please select Image. Psst. You can select image by touching on the circle image. !', duration: duration, context: context);
                      }
                      else if(_passwordController.text != _confirmPasswordController.text){
                        snackBar(content: 'Please provide same confirm password', duration: duration, context: context);
                      }
                      else {
                        signupUser();
                      }
                    },
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(resize.screenLayout(25, context)),
                    ),
                    backgroundColor: color_mode.secondaryColor,
                    enableFeedback: true,
                    child: (isLoading==false)?Text('Sign Up',
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
                SizedBox(height: resize.screenLayout(10, context),),
                Container(
                  child: Center(child: Text('-OR-',
                    style: TextStyle(
                      color: color_mode.secondaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
                ),
                SizedBox(height: resize.screenLayout(20, context),),
                Container(
                  child: Center(child: Text('Sign up using ',
                    style: TextStyle(
                      color: color_mode.secondaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
                ),
                SizedBox(height: resize.screenLayout(20, context),),
                GestureDetector(
                  onTap: (){
                  },
                  child: Center(
                    child: googleButton(context: context),
                  ),
                ),
                SizedBox(height: resize.screenLayout(40, context),),
                Row(
                  children: [
                    Text('Already have account?',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: color_mode.secondaryColor,
                          fontSize: resize.screenLayout(26, context)
                      ),
                    ),
                    SizedBox(width: resize.screenLayout(15, context),),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context, CustomPageRouteSide(child: const LoginScreen()));
                      },
                      child: Text('Sign In',
                        style: TextStyle(
                            fontSize: resize.screenLayout(28, context),
                            fontWeight: FontWeight.w700,
                            color: color_mode.tertiaryColor
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
