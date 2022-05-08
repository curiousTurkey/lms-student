import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lm_student/Reusable_Utils/Colors.dart' as color_mode;
import 'package:lm_student/Reusable_Utils/Heightwidth.dart' as height_width;
import 'package:lm_student/Reusable_Utils/Responsive.dart' as resize;
import 'package:lm_student/Reusable_Utils/TextFormField.dart';

import '../../Resources/ProfileUpdateMethods.dart';
import '../snackBar.dart';

update(BuildContext context,TextEditingController textEditingController,String labelText){
  switch(labelText){
    case 'University Reg No' : updateRegNumber(context, textEditingController);
    break;
    case 'Admission Number'  : updateAdmissionNumber(context, textEditingController);
    break;
    case 'Dept' : updateDept(context, textEditingController);
    break;
    case 'Mobile' : updateMobile(context, textEditingController);
    break;
  }
}

updateRegNumber(BuildContext context,TextEditingController textEditingController) async {
  if(textEditingController.text.length != 12){
    String finalResult = "Provide valid university Reg no";
    snackBar(content: finalResult, duration: 2000, context: context);
  }
  else {
    String finalResult = await ProfileUpdate().updateRegNo(
        regNo: textEditingController.text);
    if (finalResult == 'success') {
      snackBar(content: 'Register number updated successfully',
          duration: 1500,
          context: context);
    }
    else {
      snackBar(content: finalResult, duration: 1500, context: context);
    }
  }
}

updateAdmissionNumber(BuildContext context,TextEditingController textEditingController) async {

  String finalResult = await ProfileUpdate().updateAdmissionNumber(admissionNumber: textEditingController.text);
  if(finalResult == 'success'){
    snackBar(content: 'Admission number updated successfully', duration: 1500, context: context);
  }
  else{
    snackBar(content: finalResult, duration: 1500, context: context);
  }

}

updateDept(BuildContext context,TextEditingController textEditingController) async {

  String finalResult = await ProfileUpdate().updateDepartment(deptName: textEditingController.text);
  if(finalResult == 'success'){
    snackBar(content: 'Department updated successfully', duration: 1500, context: context);
  }
  else{
    snackBar(content: finalResult, duration: 1500, context: context);
  }
}

updateBatch(BuildContext context,String semName) async {

  String finalResult = await ProfileUpdate().updateSemester(semName: semName);
  if(finalResult == 'success'){
    snackBar(content: 'Batch name updated successfully', duration: 1500, context: context);
  }
  else{
    snackBar(content: finalResult, duration: 1500, context: context);
  }
}

updateMobile(BuildContext context,TextEditingController textEditingController) async {
  if(textEditingController.text.length != 10){
    String finalResult = "Provide valid mobile number";
    snackBar(content: finalResult, duration: 2000, context: context);
  }
  else {
    String finalResult = await ProfileUpdate().updateMobile(
        mobileNumber: textEditingController.text);
    if (finalResult == 'success') {
      snackBar(content: 'Mobile number updated successfully',
          duration: 1500,
          context: context);
    }
    else {
      snackBar(content: finalResult, duration: 1500, context: context);
    }
  }
}
Container updateDetails(BuildContext context,
    TextEditingController textEditingController,
    Icon prefixIcon,
    String labelText,
    TextInputType textInputType,
    String hintText,
    ){
  return Container(
    height: height_width.getHeight(context)/3,
    width: height_width.getWidth(context),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(resize.screenLayout(40, context))),
    ),
    child: Column(
      children: [
        Padding(
          padding:EdgeInsets.only(bottom: resize.screenLayout(20, context)),
          child: Container(
            height: resize.screenLayout(3, context),
            width: height_width.getWidth(context)/3,
            decoration: BoxDecoration(
              color: color_mode.secondaryColor
            ),
          ),
        ),
        SizedBox(height: resize.screenLayout(50, context),),
        TextForm(textEditingController:
        textEditingController,
            prefixIcon: prefixIcon,
            textInputType: textInputType,
            labelText: labelText,
            hintText: hintText),
        SizedBox(height: resize.screenLayout(55, context),),
        Container(
          height: resize.screenLayout(80, context),
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(resize.screenLayout(20, context)))
          ),
          child: FloatingActionButton(
              backgroundColor: color_mode.secondaryColor,
              onPressed: () {
                if(textEditingController.text.isNotEmpty) {
                  update(context, textEditingController, labelText);
                  Navigator.pop(context);
                }
                else{
                  snackBar(content: 'Provide ' + labelText + ' details', duration: 1500, context: context);
                }
              },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(resize.screenLayout(25, context)),
            ),
            child: const Text("Update"),
          ),
        )
      ],
    )
  );
}