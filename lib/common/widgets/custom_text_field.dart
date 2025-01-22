import 'package:flutter/material.dart';
import 'package:todo/common/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.hintText,
      required this.controller,
      this.maxLines,
      required this.validator,
      this.borderRadius});

  final String? hintText;
  final TextEditingController? controller;
  final int? maxLines;
  final double? borderRadius;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: AppColors.textBlack, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 0)),
          hintText: hintText,
          hintStyle: TextStyle()),
    );
  }
}
