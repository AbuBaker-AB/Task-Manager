import 'package:flutter/material.dart';

import '../../../api/api_caller.dart';
import '../../../api/urls.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../tasks/models/task_model.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  bool _isLoading = true;
  List<TaskModel> _taskList = [];

  @override
  void initState() {
    super.initState();
    _fetchTasks("All"); 
  }

  Future<void> _fetchTasks(String status) async {
    setState(() {
      _isLoading = true;
    });


    String url = status == 'All'
        ? TMUrls.AllTask('New') 
        : TMUrls.AllTask(status);

    final response = await ApiCaller.getRequest(URL: url);

    if (response.isSuccess) {
      final list = response.responseData['data'] as List;
      _taskList = list.map((e) => TaskModel.fromJson(e)).toList();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.errorMessage ?? 'Failed to load tasks')),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppColors.scaffold,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/all-tasks', (route) => false),
          ),
          title: const Text(
            "All Tasks",
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        body: Column(
          children: [
            Container(
              color: Colors.white,
              child: TabBar(
                isScrollable: true,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.textHint,
                indicatorColor: AppColors.primary,
                onTap: (index) {
                 
                  const statuses = ['All', 'Pending', 'In Progress', 'Completed'];
                  _fetchTasks(statuses[index]);
                },
                tabs: const [
                  Tab(text: "All"),
                  Tab(text: "Pending"),
                  Tab(text: "In Progress"),
                  Tab(text: "Completed"),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _taskList.isEmpty
                  ? Center(child: Text("No tasks found", style: AppTextStyles.bodySecondary))
                  : ListView.builder(
                padding: const EdgeInsets.all(AppSpacing.md),
                itemCount: _taskList.length,
                itemBuilder: (context, index) {
                  final task = _taskList[index];
                  return _buildTaskCard(
                    task.title ?? '',
                    task.description ?? '',
                    task.status ?? 'Pending',
                    AppColors.info,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskCard(String title, String description, String status, Color statusColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.titleMedium.copyWith(fontSize: 14)),
          const SizedBox(height: 4),
          Text(description, style: AppTextStyles.bodySecondary.copyWith(fontSize: 12)),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(AppRadius.circular),
                ),
                child: Text(
                  status,
                  style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  Icon(Icons.edit_square, color: AppColors.primary, size: 20),
                  const SizedBox(width: AppSpacing.sm),
                  Icon(Icons.delete, color: AppColors.error, size: 20),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
