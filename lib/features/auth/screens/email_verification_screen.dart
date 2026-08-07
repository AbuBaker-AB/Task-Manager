import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/auth_footer.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Graphic - Locked to bottom right
          Positioned(
            right: -120,
            bottom: -120,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.border.withOpacity(0.5),
                  width: 1,
                ),
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
                border: Border.all(
                  color: AppColors.border.withOpacity(0.5),
                  width: 1,
                ),
              ),
            ),
          ),

          // Scrollable Foreground Content
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xxl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),

                    // Utilizing the subtitle property of AuthHeader
                    const AuthHeader(
                      title: "Your Email Address",
                      subtitle: "A 6-digit verification pin will send to your email address.",
                    ),

                    const SizedBox(height: AppSpacing.section),

                    AuthTextField(
                      controller: emailController,
                      hintText: "Email",
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: AppSpacing.section),

                    PrimaryButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/pin-verification');
                      },
                    ),

                    const SizedBox(height: 48),

                    AuthFooter(
                      text: "Have account?",
                      actionText: "Sign in",
                      onTap: () {
                        // Navigates back to the Login Screen
                        Navigator.pop(context);
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