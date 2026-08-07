import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../widgets/auth_header.dart';
import '../widgets/password_text_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/auth_footer.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            right: -120,
            bottom: -120,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.border.withOpacity(0.5), width: 1),
              ),
            ),
          ),
          Positioned(
            right: -60,
            bottom: -60,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.border.withOpacity(0.5), width: 1),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xxl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),

                    const AuthHeader(
                      title: "Set Password",
                      subtitle: "Enter your new password to proceed with your account.",
                    ),

                    const SizedBox(height: AppSpacing.section),

                    PasswordTextField(
                      controller: passwordController,
                      hintText: "Password",
                      textInputAction: TextInputAction.next,
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    PasswordTextField(
                      controller: confirmPasswordController,
                      hintText: "Confirm Password",
                      textInputAction: TextInputAction.done,
                    ),

                    const SizedBox(height: AppSpacing.section),

                    PrimaryButton(
                      text: "Confirm",
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                    ),

                    const SizedBox(height: 48),

                    AuthFooter(
                      text: "Have account?",
                      actionText: "Sign in",
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                      },
                    ),

                    const SizedBox(height: AppSpacing.section),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
