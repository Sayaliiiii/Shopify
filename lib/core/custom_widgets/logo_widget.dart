
import 'package:flutter/material.dart';

Image logoWidget({required String imagePath}){
  return Image.asset(
    imagePath,
    fit: BoxFit.fitWidth,
    width: 280,
    height: 260,
    // color: Colors.white,
  );
}