import 'package:flutter/material.dart';
import 'package:todo/common/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.paddingHorizontal,
    this.paddingVertical,
    this.icon,
  });

  final String text;
  final void Function() onPressed;
  final bool isLoading;
  final double? paddingHorizontal;
  final double? paddingVertical;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal ?? 0,
          vertical: paddingVertical ?? 0,
        ),
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 56),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2.5,
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 20),
                  const SizedBox(width: 8),
                ],
                Text(text),
              ],
            ),
    );
  }
}
