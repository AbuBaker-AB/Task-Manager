import 'package:flutter/material.dart';

import '../../../api/api_caller.dart';
import '../../../api/urls.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/password_text_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/auth_footer.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    mobileController.dispose();
    passwordController.dispose();
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
                    const SizedBox(height: 40),

                    const AuthHeader(
                      title: "Join With Us",
                    ),

                    const SizedBox(height: AppSpacing.section),

                    AuthTextField(
                      controller: emailController,
                      hintText: "Email",
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    AuthTextField(
                      controller: firstNameController,
                      hintText: "First Name",
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    AuthTextField(
                      controller: lastNameController,
                      hintText: "Last Name",
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    AuthTextField(
                      controller: mobileController,
                      hintText: "Mobile",
                      keyboardType: TextInputType.phone,
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    PasswordTextField(
                      controller: passwordController,
                      hintText: "Password",
                      textInputAction: TextInputAction.done,
                    ),

                    const SizedBox(height: AppSpacing.section),

                    PrimaryButton(
                      onPressed: () async {
                        if (emailController.text.trim().isEmpty ||
                            firstNameController.text.trim().isEmpty ||
                            lastNameController.text.trim().isEmpty ||
                            mobileController.text.trim().isEmpty ||
                            passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please fill all the fields')),
                          );
                          return;
                        }

                        Map<String, dynamic> requestBody = {
                          "email": emailController.text.trim(),
                          "firstName": firstNameController.text.trim(),
                          "lastName": lastNameController.text.trim(),
                          "mobile": mobileController.text.trim(),
                          "password": passwordController.text,
                          "photo": "" 
                        };

                        final response = await ApiCaller.postRequest(
                          URL: TMUrls.SignupURL,
                          body: requestBody,
                        );

                        if (response.isSuccess) {
                          
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Registration successful! Please login.'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/login',
                                (route) => false,
                          );
                        } else {
                         
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                response.responseData?['data'] ?? 'Registration failed. Try again.',
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
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
