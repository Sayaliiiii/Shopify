
import 'package:flutter/material.dart';

hexStringToColor(String hexColor){
  hexColor=hexColor.toUpperCase().replaceAll("#", "");
  if(hexColor.length==6){
    hexColor="FF"+hexColor;
  }
  return Color(int.parse(hexColor,radix: 16));
}
class ColorsA{
  final appbarColor=hexStringToColor("26547C");
  final drawerColor=Colors.white;
  final borderColor=Colors.white;
}