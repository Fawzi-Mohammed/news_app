import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/theme/light_color.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'TimesNewRoman',
  brightness: Brightness.light,
  scaffoldBackgroundColor: LightColors.background,
  primaryColor: LightColors.primaryColor,
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFFFFFFFF),
    titleTextStyle: TextStyle(
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w700,
      color: LightColors.textPrimary,
    ),
    centerTitle: true,
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.white),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: LightColors.primaryColor,
      foregroundColor: const Color(0xFFFFFCFC),
      textStyle: TextStyle(
        fontSize: AppSizes.sp16,
        fontWeight: FontWeight.w400,
      ),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      minimumSize: Size.fromHeight(AppSizes.h52),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: LightColors.primaryColor),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: const TextStyle(color: Color(0xFF9E9E9E)),
    filled: true,
    fillColor: const Color(0xFFFFFFFF),
    focusColor: const Color(0xFFD1DAD6),
    errorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Colors.red, width: 0.5),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: 0.5),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: 0.5),
    ),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: 0.5),
    ),
    contentPadding: EdgeInsets.all(AppSizes.pw16),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: LightColors.background,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: LightColors.primaryColor,
    unselectedItemColor: LightColors.textSecondary,
    showUnselectedLabels: true,
  ),
  dividerTheme: const DividerThemeData(color: Color(0xFFD1DAD6)),
);
