
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lm_student/Reusable_Utils/Colors.dart';
import 'package:lm_student/Reusable_Utils/Heightwidth.dart' as height_width;
import 'package:lm_student/Reusable_Utils/Responsive.dart';


   dialogBox(BuildContext context,String title,Widget content) async {
    await showDialog(
        context: context,
        builder: (context){
        return AlertDialog(
          backgroundColor: primaryColor,
          elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),

      title: Center(child: Text(title,
        style: TextStyle(
          fontSize: screenLayout(38, context),
          fontWeight: FontWeight.bold,
        ),
      )),
      content: content
        );
       }
    );
   }

