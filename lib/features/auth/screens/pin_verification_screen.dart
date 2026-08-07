import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../widgets/auth_header.dart';
import '../widgets/otp_input_box.dart';
import '../widgets/primary_button.dart';
import '../widgets/auth_footer.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
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
                      title: "PIN Verification",
                      subtitle: "A 6 digit verification pin will send to your email address.",
                    ),

                    const SizedBox(height: AppSpacing.section),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(6, (index) {
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: index == 5 ? 0 : 8.0),
                            child: OtpInputBox(
                              controller: _controllers[index],
                              focusNode: _focusNodes[index],
                              nextFocusNode: index < 5 ? _focusNodes[index + 1] : null,
                            ),
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: AppSpacing.section),

                    PrimaryButton(
                      text: "Verify", 
                      onPressed: () {
                        Navigator.pushNamed(context, '/set-password');
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
