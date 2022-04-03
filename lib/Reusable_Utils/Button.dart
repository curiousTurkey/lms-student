import 'package:flutter/material.dart';
import 'package:lm_student/Reusable_Utils/Heightwidth.dart' as height_width;
import 'package:lm_student/Reusable_Utils/Colors.dart' as color_mode;
import 'package:lm_student/Reusable_Utils/Responsive.dart' as resize;

Container googleButton ({
  required BuildContext context,
}){
  return Container(
    alignment: Alignment.center,
    height: resize.screenLayout(80, context),
    width: resize.screenLayout(70, context),
    padding: EdgeInsets.all(resize.screenLayout(70, context)),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white,
      boxShadow: [
        BoxShadow(
            color: Colors.black,
            blurRadius: resize.screenLayout(20, context)
        )
      ],
      image: const DecorationImage(
        image: AssetImage('assets/logos/google.png'),
      ),
    ),
  );
}