import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: Color(0xFFC53030),
  useMaterial3: true,
  scaffoldBackgroundColor: Color(0xFFF5F5F5),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Color(0xFFC53030),
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFFC53030),
      foregroundColor: Color(0xFFFCFCFC),
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFFFFFFFF),
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Color(0xFF4E4B66),
    ),
  )
);
