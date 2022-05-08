import 'Package:lm_student/Reusable_Utils/Colors.dart' as color_mode;
import 'package:flutter/material.dart';
import 'package:lm_student/Reusable_Utils/HeightWidth.dart' as heightwidth;
import 'package:lm_student/Reusable_Utils/Responsive.dart' as resize;

AppBar appBar ({
  required BuildContext context,
  required String title
}) {
  return AppBar(
    centerTitle: true,
    backgroundColor: color_mode.secondaryColor,
    title: Text(title,
      style: TextStyle(
          color: color_mode.primaryColor,
          fontSize: resize.screenLayout(30, context)
      ),
    ),
  );
}