import 'package:flutter/material.dart';
import 'package:todo/common/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.isLoading = false});
  final String text;
  final void Function() onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            textStyle: TextStyle(color: Colors.white, fontSize: 24),
            backgroundColor: AppColors.primaryColor,
            minimumSize: Size(double.infinity, 50)),
        onPressed: onPressed,
        child: isLoading ? CircularProgressIndicator() : Text(text));
  }
}
