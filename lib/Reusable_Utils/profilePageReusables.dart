import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lm_student/Reusable_Utils/Colors.dart' as color_mode;
import 'package:lm_student/Reusable_Utils/Responsive.dart' as resize;
import 'package:lm_student/Reusable_Utils/TextFormField.dart';
import 'package:lm_student/Resources/ProfileUpdateMethods.dart';
import 'package:lm_student/Reusable_Utils/snackBar.dart';

Row buildMainHeadingRow(BuildContext context,String text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      profileItemHeadingText(context,text),
    ],
  );
}

Row buildRowItems(BuildContext context,String label, String value, Widget Icon) {
  return Row(
    children: [
      profileItems(context,label),
      const Spacer(),
      profileItemsValue(context, value),
      Icon,
    ],
  );
}

Text profileItems(BuildContext context,String text) {
  return Text(
    text,
    style: TextStyle(
        color: color_mode.tertiaryColor,
        fontSize: resize.screenLayout(27, context),
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2),
  );
}
Text profileItemsValue(BuildContext context,String text) {
  return Text(
    text,
    style: TextStyle(
        color: color_mode.tertiaryColor,
        fontSize: resize.screenLayout(27, context),
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2),
  );
}
Text profileItemHeadingText(BuildContext context, String text) {
  return Text(text,
    style: TextStyle(
        color: color_mode.tertiaryColor,
        fontSize: resize.screenLayout(45, context),
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2),
  );
}


