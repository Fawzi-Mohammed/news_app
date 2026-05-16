import 'package:flutter/material.dart';

class ViewAllComponent extends StatelessWidget {
  const ViewAllComponent({
    super.key,
    required this.title,
    this.titleColor,
    required this.onTap,
  });
  final String title;
  final Color? titleColor;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: .center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: titleColor ?? Color(0xFFFFFCFC),
            ),
          ),
          InkWell(
            onTap: onTap,
            child: Text(
              'View all',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: titleColor ?? Color(0xFFFFFCFC),
                decoration: TextDecoration.underline,
                decorationThickness: 2,
                decorationColor: titleColor ?? Color(0xFFFFFCFC),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
