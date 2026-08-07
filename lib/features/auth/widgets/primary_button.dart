import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final String? text; 
  
  const PrimaryButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppRadius.sm,
            ),
          ),
        ),
        child: isLoading
            ? const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white,
          ),
        )
            : text != null
            ? Text(
          text!,
          style: AppTextStyles.button,
        )
     
            : const Icon(
          Icons.arrow_circle_right_outlined,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}
