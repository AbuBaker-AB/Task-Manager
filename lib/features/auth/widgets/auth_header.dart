import 'package:flutter/material.dart';

import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String? subtitle;

  const AuthHeader({
    super.key,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          title,
          style: AppTextStyles.headingLarge,
        ),

        if (subtitle != null) ...[
          const SizedBox(height: AppSpacing.sm),

          Text(
            subtitle!,
            style: AppTextStyles.bodySecondary,
          ),
        ],

      ],
    );
  }
}