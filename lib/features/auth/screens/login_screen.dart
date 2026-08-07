// import 'package:flutter/material.dart';
//
// import '../../../core/constants/app_spacing.dart';
// import '../widgets/auth_header.dart';
// import '../widgets/auth_text_field.dart';
// import '../widgets/password_text_field.dart';
// import '../widgets/primary_button.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//
//   final TextEditingController emailController =
//   TextEditingController();
//
//   final TextEditingController passwordController =
//   TextEditingController();
//
//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(
//               AppSpacing.xxl,
//             ),
//             child: Column(
//               crossAxisAlignment:
//               CrossAxisAlignment.start,
//               children: [
//
//                 const SizedBox(height: 55),
//
//                 AuthHeader(
//                   title: "Get Started With",
//                 ),
//
//                 SizedBox(
//                   height: AppSpacing.section,
//                 ),
//
//                 AuthTextField(
//                   controller: emailController,
//                   hintText: "Email",
//                   keyboardType: TextInputType.emailAddress,
//                 ),
//
//                 const SizedBox(
//                   height: AppSpacing.lg,
//                 ),
//
//                 PasswordTextField(
//                   controller: passwordController,
//                 ),
//
//                 const SizedBox(
//                   height: AppSpacing.section,
//                 ),
//
//                 PrimaryButton(
//                   onPressed: () {
//                     // TODO:
//                     // Login API
//                   },
//                 ),
//
//                 const SizedBox(
//                   height: 12,
//                 ),
//
//                 Center(
//                   child: TextButton(
//                     onPressed: () {
//                       // TODO:
//                       // Forgot Password Screen
//                     },
//                     child: const Text(
//                       "Forgot Password?",
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(
//                   height: AppSpacing.section,
//                 ),
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../../../api/api_caller.dart';
import '../../../api/urls.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../models/user_model.dart';
import '../providers/auth_controller.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/password_text_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/auth_footer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // FIX: The Stack is now the root of the body, outside the SafeArea and ScrollView
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

                    const AuthHeader(
                      title: "Get Started With",
                    ),

                    const SizedBox(height: AppSpacing.section),

                    AuthTextField(
                      controller: emailController,
                      hintText: "Email",
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    PasswordTextField(
                      controller: passwordController,
                    ),

                    const SizedBox(height: AppSpacing.section),

                    PrimaryButton(
                      onPressed: () async {
                        // 1. Validate fields are not empty
                        if (emailController.text.trim().isEmpty ||
                            passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please enter email and password')),
                          );
                          return;
                        }

                        // 2. Prepare request body
                        Map<String, dynamic> requestBody = {
                          "email": emailController.text.trim(),
                          "password": passwordController.text,
                        };

                        // 3. Show loading indicator (optional or handled via button state)

                        // 4. Call API using your sir's ApiCaller and TMUrls
                        final response = await ApiCaller.postRequest(
                          URL: TMUrls.LoginURL,
                          body: requestBody,
                        );

                        if (response.isSuccess) {
                          // 5. Extract token and user model from response data
                          String token = response.responseData['token'];
                          var userDataJson = response.responseData['data'];
                          UserModel userModel = UserModel.fromJson(userDataJson);

                          // 6. Save using AuthController
                          await AuthController.saveUserData(userModel, token);

                          // 7. Navigate to Dashboard
                          if (!context.mounted) return;
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/all-tasks',
                                (route) => false,
                          );
                        } else {
                          // 8. Show error message from API
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                response.responseData?['data'] ?? 'Login failed. Please try again.',
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                    ),

                    // FIX: Increased the height from 12 to 48 to match the target design
                    const SizedBox(height: 55),

                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/email-verification');
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey, // Keeps this specific text grey
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    AuthFooter(
                      text: "Don't have an account?",
                      actionText: "Sign up",
                      onTap: () {
                        Navigator.pushNamed(context, '/signup');
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