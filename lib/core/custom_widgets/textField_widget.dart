
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopify/core/utils/colors.dart';

TextField reusableTextField(
    {
      bool isSearch =false,
      bool isAddress =false,
      required String text,
   required IconData icon,
   required bool isPasswordType,
    required TextEditingController controller,
    required Function(String) onChange}) {
  print('boolll${isSearch}');
  return TextField(
    minLines: isAddress ? 2 : 1,
    maxLines: isAddress ? null:1,
    // expands: isAddress   ?true : false,
    onChanged: onChange,
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.black,
    style: TextStyle(color: Colors.black.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon:   Icon(
        icon,
        color: Colors.black,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide:  BorderSide(width: isSearch? 0: 5, style: isSearch? BorderStyle.none :BorderStyle.solid,  )),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}