import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSvgPicture extends StatelessWidget {
  const CustomSvgPicture({
    super.key,
    required this.path,
    this.color,
    this.witheColorFilter = true,
    this.width,
    this.height,
  });
  const CustomSvgPicture.withColorFilter({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.color,
  }) : witheColorFilter = false;
  final String path;
  final double? width;
  final double? height;
  final Color? color;
  final bool witheColorFilter;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
      colorFilter: witheColorFilter
          ? ColorFilter.mode(
              color ?? Theme.of(context).colorScheme.secondary,
              BlendMode.srcIn,
            )
          : null,
    );
  }
}
