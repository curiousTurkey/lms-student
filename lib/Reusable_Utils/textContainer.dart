import 'package:flutter/material.dart';
import 'package:lm_student/Reusable_Utils/Responsive.dart' as resize;
import 'package:lm_student/Reusable_Utils/Colors.dart' as color_mode;

Container reusableContainerTextWidget({required BuildContext context,required String text,required double size,required Color color}) {
  return Container(
    alignment: Alignment.center,
    height: resize.screenLayout(70, context),
    width: double.maxFinite,
    child: Text(text,style: TextStyle(
        fontWeight: FontWeight.w400,
        color: color,
        fontFamily: 'Fredoka',
        fontSize: resize.screenLayout(size, context)

    ),),
  );
}