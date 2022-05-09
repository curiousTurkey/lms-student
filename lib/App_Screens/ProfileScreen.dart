import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lm_student/Resources/ProfileUpdateMethods.dart';
import 'package:lm_student/Resources/Storage_method.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lm_student/Reusable_Utils/ProfilePageContainers/UpdateDetails.dart';
import 'package:lm_student/Reusable_Utils/Responsive.dart' as resize;
import 'package:lm_student/Reusable_Utils/Colors.dart' as color_mode;
import 'package:lm_student/Reusable_Utils/Heightwidth.dart' as height_width;
import 'package:lm_student/Reusable_Utils/alertDialogprofile.dart';
import 'package:provider/provider.dart';
import '../Models/User.dart';
import '../Providers/UserProvider.dart';
import '../Reusable_Utils/profilePageReusables.dart';
import '../Reusable_Utils/snackBar.dart';
import '../Reusable_Utils/textContainer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _universityRegNoUpdate = TextEditingController();
  final TextEditingController _admissionNumberController =
      TextEditingController();
  final TextEditingController _deptNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _batchNameController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _admissionNumberController.dispose();
    _universityRegNoUpdate.dispose();
    _deptNameController.dispose();
    _phoneNumberController.dispose();
    _batchNameController.dispose();
  }

  selectImageGallery() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    File file = File(image!.path); //converting XFile as File
    snackBar(
        content: 'Image uploading , please stay in screen.',
        duration: 1800,
        context: context);
    String photoUrl = await StorageMethods()
        .uploadImageToStorage('Students Bio Picture', file);
    //storing to firestore
    String finalResult = await ProfileUpdate().updateImage(imageUrl: photoUrl);
    snackBar(content: finalResult, duration: 1800, context: context);
  }

  selectImageCamera() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    File file = File(image!.path);
    snackBar(
        content: 'Image uploading, please stay in screen.',
        duration: 1800,
        context: context);
    String photoUrl = await StorageMethods()
        .uploadImageToStorage('Students Bio Picture', file);

    String finalResult = await ProfileUpdate().updateImage(imageUrl: photoUrl);
    snackBar(content: finalResult, duration: 1800, context: context);
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(value: item, child: Text(item),);
  final List<String> semList = ['Select Semester','1st Sem','2nd Sem','3rd Sem','4th Sem','5th Sem','6th Sem'];
  final List<String> listItem = ['Select Department','Computer Applications'];
  String semValue = "Select Semester";
  String value = "Select Department";

  void updateSem(String sem) async {

    String finalResult = await ProfileUpdate().updateSemester(semName: sem);
    if(finalResult == 'success'){
      snackBar(content: 'Updation Success', duration: 2000, context: context);
    }
    else{
      snackBar(content: finalResult, duration: 2000, context: context);
    }
  }
  void updateDepartment(String dept) async {
    String finalResult = await ProfileUpdate().updateDepartment(deptName: dept);
    if(finalResult == 'success'){
      snackBar(content: 'Updation Success', duration: 2000, context: context);
    }
    else{
      snackBar(content: finalResult, duration: 2000, context: context);
    }
  }

  _displayDialog(BuildContext context) async {
    await showDialog(
        barrierColor: Colors.white70,
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(
              'Choose Location',
              style: TextStyle(
                color: color_mode.tertiaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  selectImageCamera();
                  Navigator.pop(context);
                },
                child: Text(
                  'Camera',
                  style: TextStyle(
                      color: color_mode.secondaryColor,
                      fontWeight: FontWeight.w500,
                      backgroundColor: color_mode.primaryColor),
                ),
              ),
              SizedBox(
                height: resize.screenLayout(20, context),
              ),
              SimpleDialogOption(
                onPressed: () {
                  selectImageGallery();
                  Navigator.pop(context);
                },
                child: Text(
                  'Gallery',
                  style: TextStyle(
                      color: color_mode.secondaryColor,
                      fontWeight: FontWeight.w500,
                      backgroundColor: color_mode.primaryColor),
                ),
              ),
            ],
          );
        });
  }
  String name = '';
  String universityReg = '';
  String admission = '';
  String department = '';
  String mobile = '';


  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserProvider>(context).getUser;
    String imageUrl = '';
    String semester = '';
    String userId = userModel.userId;
    final Stream<DocumentSnapshot<Map<String, dynamic>>> profile = FirebaseFirestore.instance.collection('users').doc(userId).snapshots();
    final SizedBox sizedBox =
        SizedBox(height: resize.screenLayout(23, context));
    return Scaffold(
        backgroundColor: color_mode.primaryColor,
        body: StreamBuilder<Object>(
            stream: profile,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Error 504. Server side issue.'),
                );
              } else {
                if (snapshot.hasData) {
                  var data = snapshot.data
                      as DocumentSnapshot;// storing the database document snapshot.
                  name = data['name'];
                  universityReg = data['universityRegNo'];
                  admission = data['admissionNumber'];
                  department = data['deptName'];
                  mobile = data['mobileNumber'];
                  imageUrl = data['bio pic url'];
                  semester = data['semester'];
                }
              }
              return Container(
                color: Colors.white10,
                //decoration: BoxDecoration(),
                height: height_width.getHeight(context),
                width: double.maxFinite,
                padding: const EdgeInsets.all(1),
                child: ListView(
                  children: [
                    Stack(
                      children: [
                        Container(
                          alignment: Alignment.topCenter,
                          margin: const EdgeInsets.all(5),
                          height: height_width.getHeight(context) / 2.15,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(
                                  resize.screenLayout(28, context))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: resize.screenLayout(80, context),
                              ),
                              Material(
                                  elevation: 4,
                                  shape: const CircleBorder(),
                                  clipBehavior: Clip.hardEdge,
                                  color: color_mode.tertiaryColor,
                                  shadowColor: color_mode.secondaryColor,
                                  animationDuration:
                                      const Duration(milliseconds: 1000),
                                  child: Ink.image(
                                    image: NetworkImage(userModel.imageUrl),
                                    fit: BoxFit.cover,
                                    width: resize.screenLayout(250, context),
                                    height: resize.screenLayout(250, context),
                                    child: InkWell(
                                      splashColor: color_mode.secondaryColor
                                          .withOpacity(.5),
                                      onTap: () => _displayDialog(context),
                                    ),
                                  )),
                              sizedBox,
                              reusableContainerTextWidget(
                                  context: context,
                                  text: userModel.fullName,
                                  size: 50,
                                  color: color_mode.secondaryColor2),
                              reusableContainerTextWidget(
                                  context: context,
                                  text: userModel.courseType,
                                  size: 35,
                                  color: color_mode.spclColor2),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: resize.screenLayout(30, context),
                          vertical: resize.screenLayout(40, context)),
                      height: height_width.getHeight(context) / 1.5,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: color_mode.tertiaryColor, blurRadius: 4)
                        ],
                        color: color_mode.primaryColor,
                        borderRadius: BorderRadius.only(
                          topRight:
                              Radius.circular(resize.screenLayout(50, context)),
                          topLeft:
                              Radius.circular(resize.screenLayout(50, context)),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: resize.screenLayout(30, context),
                          ),
                          buildMainHeadingRow(context, 'Academic Details'),
                          SizedBox(
                            height: resize.screenLayout(5, context),
                          ),
                          buildRowItems(
                              context,
                              'University Reg.No',
                              universityReg,
                              Padding(
                                padding: EdgeInsets.only(
                                    left: resize.screenLayout(8, context),
                                    bottom: resize.screenLayout(7, context)),
                                child: InkWell(
                                    onTap: () async {
                                      dialogBox(
                                          context,
                                          'Update Reg No',
                                          updateDetails(
                                              context,
                                              _universityRegNoUpdate,
                                              const Icon(
                                                  Icons.app_registration),
                                              'University Reg No',
                                              TextInputType.number,
                                              'Update reg number'));
                                    },
                                    child: const Icon(Icons.edit)),
                              )),
                          sizedBox,
                          buildRowItems(
                              context,
                              'Admission Number',
                              admission,
                              Padding(
                                padding: EdgeInsets.only(
                                    left: resize.screenLayout(8, context),
                                    bottom: resize.screenLayout(7, context)),
                                child: GestureDetector(
                                    onTap: () async {
                                      dialogBox(
                                          context,
                                          'Update Admission Number',
                                          updateDetails(
                                              context,
                                              _admissionNumberController,
                                              const Icon(
                                                  Icons.app_registration),
                                              'Admission Number',
                                              TextInputType.number,
                                              'Provide admission Number'));
                                    },
                                    child: const Icon(Icons.edit)),
                              )),
                          sizedBox,
                          buildRowItems(
                              context,
                              'Department',
                              department,
                              Padding(
                                padding: EdgeInsets.only(
                                    left: resize.screenLayout(8, context),
                                    bottom: resize.screenLayout(7, context)),
                                child: GestureDetector(
                                    onTap: () async {
                                      await dialogBox(context,
                                          'Department',
                                          SizedBox(
                                            height: resize.screenLayout(400, context),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: resize.screenLayout(70, context),
                                                  padding: EdgeInsets.all(resize.screenLayout(20, context)),
                                                  decoration: const BoxDecoration(
                                                  ),
                                                  child: DropdownButtonHideUnderline(
                                                    child: StatefulBuilder(
                                                      builder: (BuildContext context, StateSetter setState) {
                                                        return DropdownButton<String>(
                                                        dropdownColor: color_mode.primaryColor,
                                                        focusColor: color_mode.primaryColor,
                                                        style: TextStyle(fontSize: resize.screenLayout(30, context),
                                                        color: color_mode.secondaryColor,
                                                        fontWeight: FontWeight.w600
                                                        ),
                                                        borderRadius: BorderRadius.circular(resize.screenLayout(20, context)),
                                                        iconDisabledColor: Colors.grey,
                                                        iconEnabledColor: color_mode.secondaryColor,
                                                        icon: const Icon(Icons.arrow_downward_rounded),
                                                        enableFeedback: true,
                                                        hint: const Text('Select Department'),
                                                        isExpanded: true,
                                                        items: listItem.map(buildMenuItem).toList(),
                                                        value: value,
                                                        onChanged: (val) {
                                                        setState(() {
                                                        value = val!;
                                                        });
                                                        }
                                                        );
                                                      }
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: resize.screenLayout(100, context),),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: FloatingActionButton(
                                                        backgroundColor: color_mode.secondaryColor,
                                                        onPressed: () {
                                                          updateDepartment(value);
                                                        },
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(resize.screenLayout(25, context)),
                                                        ),
                                                        child: const Text("Update"),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                              ],
                                            ),
                                          )
                                      );

                                    },
                                    child: const Icon(Icons.edit)),
                              )),
                          sizedBox,
                          buildRowItems(
                              context,
                              'Semester',
                              semester,
                              Padding(
                                padding: EdgeInsets.only(
                                    left: resize.screenLayout(8, context),
                                    bottom: resize.screenLayout(7, context)),
                                child: GestureDetector(
                                    onTap: () async {
                                      await dialogBox(context,
                                          'Semester',
                                          SizedBox(
                                            height: resize.screenLayout(400, context),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: resize.screenLayout(70, context),
                                                  padding: EdgeInsets.all(resize.screenLayout(20, context)),
                                                  decoration: const BoxDecoration(
                                                  ),
                                                  child: DropdownButtonHideUnderline(
                                                    child: DropdownButton<String>(
                                                        dropdownColor: color_mode.primaryColor,
                                                        focusColor: color_mode.primaryColor,
                                                        style: TextStyle(fontSize: resize.screenLayout(30, context),
                                                            color: color_mode.secondaryColor,
                                                            fontWeight: FontWeight.w600
                                                        ),
                                                        borderRadius: BorderRadius.circular(resize.screenLayout(20, context)),
                                                        iconDisabledColor: Colors.grey,
                                                        iconEnabledColor: color_mode.secondaryColor,
                                                        icon: const Icon(Icons.arrow_downward_rounded),
                                                        enableFeedback: true,
                                                        hint: const Text('Select Semester'),
                                                        isExpanded: true,
                                                        items: semList.map(buildMenuItem).toList(),
                                                        value: semValue,
                                                        onChanged: (val) {
                                                          setState(() {
                                                            semValue = val!;
                                                            print(semValue);
                                                          });
                                                        }
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: resize.screenLayout(100, context),),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: FloatingActionButton(
                                                        backgroundColor: color_mode.secondaryColor,
                                                        onPressed: () {
                                                          updateSem(semValue);
                                                        },
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(resize.screenLayout(25, context)),
                                                        ),
                                                        child: const Text("Update"),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                              ],
                                            ),
                                          )
                                      );

                                    },
                                    child: const Icon(Icons.edit)),
                              )),
                          sizedBox,
                          profileItemHeadingText(context, 'Personal Details'),
                          sizedBox,
                          buildRowItems(context, 'E-mail',
                              userModel.emailAddress, const SizedBox(width: 0)),
                          sizedBox,
                          buildRowItems(
                              context,
                              'Mobile',
                              mobile,
                              Padding(
                                padding: EdgeInsets.only(
                                    left: resize.screenLayout(8, context),
                                    bottom: resize.screenLayout(7, context)),
                                child: GestureDetector(
                                    onTap: () async {
                                      await dialogBox(
                                          context,
                                          'Update Mobile',
                                          updateDetails(
                                              context,
                                              _phoneNumberController,
                                              const Icon(
                                                  Icons.phone_android_outlined),
                                              'Mobile',
                                              TextInputType.number,
                                              'Provide mobile number'));
                                    },
                                    child: const Icon(Icons.edit)),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }));
  }
}
