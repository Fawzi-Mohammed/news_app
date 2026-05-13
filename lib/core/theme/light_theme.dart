import 'package:flutter/material.dart';
import 'package:news_app/core/theme/light_color.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: LightColors.primaryColor,
  useMaterial3: true,
  progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.black),
  scaffoldBackgroundColor: LightColors.background,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: LightColors.primaryColor,
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: LightColors.primaryColor,
      foregroundColor: LightColors.background,
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: LightColors.background,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: LightColors.textPrimary,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    showUnselectedLabels: true,
    backgroundColor: LightColors.background,
    selectedItemColor: LightColors.primaryColor,
    unselectedItemColor: LightColors.textSecondary,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFFFFFFFF),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide.none,
    ),
    hintStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: LightColors.textSecondary,
    ),
    contentPadding: EdgeInsets.all(16),
  ),
);
