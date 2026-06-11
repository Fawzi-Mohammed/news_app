import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/theme/light_color.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get appBarTitle => TextStyle(
    fontSize: AppSizes.sp16,
    fontWeight: FontWeight.w700,
    color: LightColors.textPrimary,
  );

  static TextStyle get fieldTitle => TextStyle(
    fontSize: AppSizes.sp16,
    fontWeight: FontWeight.w500,
    color: LightColors.textPrimary,
  );

  static TextStyle get fieldValue => TextStyle(
    fontSize: AppSizes.sp16,
    fontWeight: FontWeight.w400,
    color: LightColors.textPrimary,
  );

  static TextStyle get inputHint => TextStyle(
    fontSize: AppSizes.sp16,
    fontWeight: FontWeight.w400,
    color: LightColors.textSecondary,
  );

  static TextStyle get screenHeadline => TextStyle(
    fontSize: AppSizes.sp20,
    fontWeight: FontWeight.w700,
    color: LightColors.textPrimary,
  );

  static TextStyle get bodyRegular => TextStyle(
    fontSize: AppSizes.sp14,
    fontWeight: FontWeight.w400,
    color: LightColors.textSecondary,
  );

  static TextStyle get buttonLabel =>
      TextStyle(fontSize: AppSizes.sp16, fontWeight: FontWeight.w400);

  static TextStyle get errorText => TextStyle(
    fontSize: AppSizes.sp12,
    fontWeight: FontWeight.w400,
    color: LightColors.error,
  );
}
