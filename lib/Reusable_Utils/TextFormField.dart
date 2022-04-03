import 'package:flutter/material.dart';
import 'package:lm_student/Reusable_Utils/Responsive.dart' as resize;
import 'Package:lm_student/Reusable_Utils/Colors.dart' as color_mode;
import 'package:form_field_validator/form_field_validator.dart';

class TextForm extends StatelessWidget {
  final bool isPass;
  final TextEditingController textEditingController;
  final Icon prefixIcon;
  final TextInputType textInputType;
  final String labelText;
  final String hintText;

  final bool isEmail;
   const TextForm({Key? key,
    required this.textEditingController,
    required this.prefixIcon,
    required this.textInputType,
    this.isPass = false,
    this.isEmail = false,
    required this.labelText,required this.hintText,
   })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(resize.screenLayout(15, context))),
      borderSide: Divider.createBorderSide(context,color: color_mode.secondaryColor,width: 1.4),
    );
    OutlineInputBorder inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(resize.screenLayout(15, context))),
      borderSide: Divider.createBorderSide(context,color: Colors.grey),
    );
    return Theme(
      data: Theme.of(context).copyWith(colorScheme: ThemeData().colorScheme.copyWith(primary: color_mode.secondaryColor)),
      child: TextFormField(
        validator: MultiValidator([
          EmailValidator(errorText: 'Provide valid email'),
          RequiredValidator(errorText: 'Required Field'),
        ]),
        controller: textEditingController,
        decoration: InputDecoration(
          focusColor: color_mode.secondaryColor,
          focusedBorder: focusedBorder,
          prefixIcon: prefixIcon,
          labelText: labelText,
          hintText: hintText,
          hintStyle: TextStyle(color: color_mode.secondaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          contentPadding: EdgeInsets.all(resize.screenLayout(20, context)),
          border: inputBorder,
          prefixIconColor: color_mode.tertiaryColor,
          labelStyle: TextStyle(color: color_mode.secondaryColor),
        ),
        keyboardType: textInputType,
        obscureText: isPass,
      ),
    );
  }
}
