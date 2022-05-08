import 'package:lm_student/Reusable_Utils/Colors.dart' as color_mode;
import 'package:flutter/material.dart';

Widget sidebarListTile({
  required String title,

  required IconData leadingIcon,
  required VoidCallback onTap,
}){
  return ListTile(
    leading: Icon(
      leadingIcon, color: color_mode.secondaryColor2,),
    title: Text(title),
    textColor: color_mode.tertiaryColor,
    trailing: Icon(Icons.arrow_forward_ios_rounded,
      color: color_mode.tertiaryColor,),
    enableFeedback: true,
    onTap: onTap,
  );
}