import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.maxLines = 1,
    required this.hintText,
    this.validator,
    required this.title,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final int? maxLines;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final String title;
  final bool obscureText;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: AppSizes.ph8),

        TextFormField(
          validator: widget.validator,
          maxLines: widget.maxLines,
          style: Theme.of(context).textTheme.labelMedium,
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.hintText,
            suffixIcon: widget.obscureText
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isVisible = !_isVisible;
                      });
                    },
                    icon: _isVisible
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  )
                : null,
          ),
          obscureText: widget.obscureText && !_isVisible,
        ),
      ],
    );
  }
}
