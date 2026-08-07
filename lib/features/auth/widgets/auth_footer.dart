// import 'package:flutter/material.dart';
//
// import '../../../core/constants/app_colors.dart';
// import '../../../core/constants/app_text_styles.dart';
//
// class AuthFooter extends StatelessWidget {
//   final String text;
//   final String actionText;
//   final VoidCallback onTap;
//
//   const AuthFooter({
//     super.key,
//     required this.text,
//     required this.actionText,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           text,
//           style: AppTextStyles.bodySecondary,
//         ),
//
//         GestureDetector(
//           onTap: onTap,
//           child: Text(
//             " $actionText",
//             style: AppTextStyles.bodySecondary.copyWith(
//               color: AppColors.primary,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class AuthFooter extends StatelessWidget {
  final String text;
  final String actionText;
  final VoidCallback onTap;

  const AuthFooter({
    super.key,
    required this.text,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // FIX: Changed color to textPrimary and added bold weight
        Text(
          text,
          style: AppTextStyles.bodySecondary.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            " $actionText",
            style: AppTextStyles.bodySecondary.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}