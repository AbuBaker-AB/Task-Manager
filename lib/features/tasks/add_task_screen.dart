import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../api/api_caller.dart';
import '../../api/urls.dart';
import '../auth/widgets/primary_button.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _assignToController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _assignToController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitTask() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> requestBody = {
        "title": _assignToController.text.trim(), // Or your separate title controller
        "description": _descriptionController.text.trim(),
        "status": "New" // Default initial status
      };

      final response = await ApiCaller.postRequest(
        URL: TMUrls.createTask,
        body: requestBody,
      );

      if (!mounted) return;

      if (response.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task added successfully!'), backgroundColor: Colors.green),
        );
        Navigator.pop(context, true); // Pop and return true to trigger a refresh on the home screen
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to add task'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          child: Form(
            key: _formKey, // Attach the form key
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.md),

                Text(
                  "Add New Task",
                  style: AppTextStyles.headingLarge,
                ),

                const SizedBox(height: AppSpacing.section),

                // Assign To Field
                TextFormField(
                  controller: _assignToController,
                  decoration: _inputDecoration("Assign to"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter who this task is assigned to';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: AppSpacing.lg),

                // Description Field (Multiline)
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 8, // Makes it a large text area
                  decoration: _inputDecoration("Description"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a task description';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: AppSpacing.section),

                // Submit Button
                PrimaryButton(
                  onPressed: _submitTask,
                  // Leaving text null shows the default arrow icon
                ),
              ],
            ),
          ),
        ),
      ),
      // Matches the bottom navigation layout shown in the mockup
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textHint,
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
            label: "Profile",
          ),
        ],
      ),
    );
  }

  // Helper method to keep the input styling consistent with your app theme
  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.all(16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: const BorderSide(color: AppColors.border, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: const BorderSide(color: AppColors.border, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: const BorderSide(color: AppColors.error, width: 1),
      ),
    );
  }
}