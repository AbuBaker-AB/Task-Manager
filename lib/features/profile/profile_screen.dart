import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../auth/widgets/auth_text_field.dart';
import '../auth/widgets/password_text_field.dart';
import '../auth/widgets/primary_button.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final TextEditingController _emailController = TextEditingController(text: "john.doe@example.com");
  final TextEditingController _firstNameController = TextEditingController(text: "John");
  final TextEditingController _lastNameController = TextEditingController(text: "Doe");
  final TextEditingController _mobileController = TextEditingController(text: "+1234 567 8900");
  final TextEditingController _passwordController = TextEditingController(text: "********");

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
           
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey.shade300,
                    child: Icon(Icons.person, size: 50, color: Colors.grey.shade500),
                  ),
                  const SizedBox(width: AppSpacing.lg),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "John Doe",
                        style: AppTextStyles.headingMedium.copyWith(fontSize: 20),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "john.doe@example.com",
                        style: AppTextStyles.bodySecondary,
                      ),
                    ],
                  )
                ],
              ),

              const SizedBox(height: AppSpacing.section),

             
              _buildFieldLabel("Email"),
              AuthTextField(
                controller: _emailController,
                hintText: "Email",
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: AppSpacing.lg),

              _buildFieldLabel("First Name"),
              AuthTextField(
                controller: _firstNameController,
                hintText: "First Name",
              ),
              const SizedBox(height: AppSpacing.lg),

              _buildFieldLabel("Last Name"),
              AuthTextField(
                controller: _lastNameController,
                hintText: "Last Name",
              ),
              const SizedBox(height: AppSpacing.lg),

              _buildFieldLabel("Mobile"),
              AuthTextField(
                controller: _mobileController,
                hintText: "Mobile",
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: AppSpacing.lg),

              _buildFieldLabel("Password"),
              PasswordTextField(
                controller: _passwordController,
                hintText: "Password",
              ),

              const SizedBox(height: AppSpacing.section),

           
              PrimaryButton(
                onPressed: () {
                
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile Updated!')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textHint,

        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/all-tasks');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/categories');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/calendar');
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, '/profile');
          }
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.task_outlined),
            activeIcon: Icon(Icons.task),
            label: "Tasks",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: "Calendar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }


  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: AppColors.textSecondary,
          fontSize: 13,
        ),
      ),
    );
  }
}
