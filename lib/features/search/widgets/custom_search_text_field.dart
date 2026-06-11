import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/core/widgets/custom_svg_picture.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({
    super.key,
    this.onChanged,
    required this.controller,
  });
  final void Function(String)? onChanged;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hint: Text('Search'),
        hintStyle: TextStyle(
          fontSize: AppSizes.sp14,
          color: Color(0xFFA0A0A0),
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: LightColors.background,

        suffixIcon: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.w18,
            vertical: AppSizes.h18,
          ),
          child: CustomSvgPicture.withColorFilter(
            path: 'assets/images/search_icon.svg',
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0XFFD3D3D3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0XFFD3D3D3)),
        ),
      ),
      controller: controller,
      onChanged: onChanged,
    );
  }
}
