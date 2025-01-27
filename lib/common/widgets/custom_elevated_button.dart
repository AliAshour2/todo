import 'package:flutter/material.dart';
import 'package:todo/common/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.isLoading = false,
      this.paddingHorizontal,
      this.paddingVertical});
  final String text;
  final void Function() onPressed;
  final bool isLoading;
  final double? paddingHorizontal;
  final double? paddingVertical;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
                horizontal: paddingHorizontal ?? 0,
                vertical: paddingVertical ?? 0),
            textStyle: TextStyle(color: Colors.white, fontSize: 18),
            backgroundColor: AppColors.primaryColor,
            minimumSize: Size(double.infinity, 50)),
        onPressed: onPressed,
        child: isLoading ? CircularProgressIndicator() : Text(text));
  }
}
