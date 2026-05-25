import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/theme/app_text_styles.dart';
import 'package:news_app/core/theme/light_color.dart';

ThemeData get lightTheme {
  return ThemeData(
    useMaterial3: true,
    fontFamily: 'TimesNewRoman',
    brightness: Brightness.light,
    scaffoldBackgroundColor: LightColors.background,
    primaryColor: LightColors.primary,
    appBarTheme: AppBarTheme(
      backgroundColor: LightColors.surface,
      titleTextStyle: AppTextStyles.appBarTitle,
      centerTitle: true,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.white,
    ),
    textTheme: TextTheme(
      titleLarge: AppTextStyles.screenHeadline,
      titleMedium: AppTextStyles.fieldTitle,
      labelMedium: AppTextStyles.fieldValue,
      bodyMedium: AppTextStyles.bodyRegular,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: LightColors.primary,
        foregroundColor: LightColors.buttonForeground,
        textStyle: AppTextStyles.buttonLabel,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        minimumSize: Size.fromHeight(AppSizes.h52),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: LightColors.primary),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: AppTextStyles.inputHint,
      filled: true,
      fillColor: LightColors.surface,
      focusColor: LightColors.inputBorder,
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: LightColors.error, width: 0.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: LightColors.inputBorder, width: 0.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: LightColors.inputBorder, width: 0.5),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: LightColors.inputBorder, width: 0.5),
      ),
      contentPadding: EdgeInsets.all(AppSizes.pw16),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: LightColors.background,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: LightColors.primary,
      unselectedItemColor: LightColors.textSecondary,
      showUnselectedLabels: true,
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      contentTextStyle: AppTextStyles.fieldValue.copyWith(
        color: LightColors.primary,
      ),
      actionTextColor: LightColors.primary,
      disabledActionTextColor: LightColors.textSecondary,
    ),
    dividerTheme: const DividerThemeData(color: LightColors.inputBorder),
  );
}
