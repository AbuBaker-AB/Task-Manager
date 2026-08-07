import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class AppLogo extends StatelessWidget {
  final double iconSize;
  final double spacing;

  const AppLogo({
    super.key,
    this.iconSize = 34,
    this.spacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.event_available,
          color: AppColors.primary,
          size: iconSize,
        ),

        SizedBox(width: spacing),

        Text(
          "TaskManager",
          style: AppTextStyles.titleMedium.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}