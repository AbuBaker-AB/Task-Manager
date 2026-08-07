// import 'package:flutter/material.dart';
//
// import '../../../core/constants/app_colors.dart';
// import '../../../core/constants/app_radius.dart';
// import '../../../core/constants/app_spacing.dart';
// import '../../../core/constants/app_text_styles.dart';
//
// class CategoriesScreen extends StatefulWidget {
//   const CategoriesScreen({super.key});
//
//   @override
//   State<CategoriesScreen> createState() => _CategoriesScreenState();
// }
//
// class _CategoriesScreenState extends State<CategoriesScreen> {
//
//   // 1. Created a static list of tasks to act as our data source
//   final List<Map<String, dynamic>> _allTasks = [
//     {
//       "title": "Design mobile app wireframe",
//       "description": "Create a clean and modern interface for the learning app dashboard.",
//       "status": "In Progress",
//       "color": AppColors.info,
//     },
//     {
//       "title": "Design mobile app wireframe",
//       "description": "Create a clean and modern interface for the learning app dashboard.",
//       "status": "Pending",
//       "color": Colors.purple.shade500,
//     },
//     {
//       "title": "Design mobile app wireframe",
//       "description": "Create a clean and modern interface for the learning app dashboard.",
//       "status": "Completed",
//       "color": AppColors.success,
//     },
//     {
//       "title": "Design mobile app wireframe",
//       "description": "Create a clean and modern interface for the learning app dashboard.",
//       "status": "Overdue", // Will only show up in the 'All' tab
//       "color": AppColors.error,
//     }
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 4,
//       child: Scaffold(
//         backgroundColor: AppColors.scaffold,
//         appBar: AppBar(
//           backgroundColor: AppColors.primary,
//           elevation: 0,
//           leading: IconButton(
//             icon: const Icon(Icons.menu, color: Colors.white),
//             onPressed: () {},
//           ),
//           title: const Text(
//             "All Tasks",
//             style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
//           ),
//         ),
//         body: Column(
//           children: [
//             Container(
//               color: Colors.white,
//               child: TabBar(
//                 isScrollable: true,
//                 labelColor: AppColors.primary,
//                 unselectedLabelColor: AppColors.textHint,
//                 indicatorColor: AppColors.primary,
//                 indicatorSize: TabBarIndicatorSize.label,
//                 indicatorWeight: 3,
//                 tabAlignment: TabAlignment.start,
//                 tabs: const [
//                   Tab(text: "All"),
//                   Tab(text: "Pending"),
//                   Tab(text: "In Progress"),
//                   Tab(text: "Completed"),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: AppSpacing.sm),
//
//             Expanded(
//               child: TabBarView(
//                 children: [
//                   // 2. Pass the specific filter criteria to the builder
//                   _buildTaskList('All'),
//                   _buildTaskList('Pending'),
//                   _buildTaskList('In Progress'),
//                   _buildTaskList('Completed'),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           currentIndex: 1,
//           type: BottomNavigationBarType.fixed,
//           selectedItemColor: AppColors.primary,
//           unselectedItemColor: AppColors.textHint,
//
//           onTap: (index) {
//             if (index == 0) {
//               Navigator.pushReplacementNamed(context, '/all-tasks');
//             } else if (index == 1) {
//               Navigator.pushReplacementNamed(context, '/categories');
//             } else if (index == 2) {
//               Navigator.pushReplacementNamed(context, '/calendar');
//             } else if (index == 3) {
//               Navigator.pushReplacementNamed(context, '/profile');
//             }
//           },
//
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.task_outlined),
//               activeIcon: Icon(Icons.task),
//               label: "Tasks",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.grid_view),
//               label: "Categories",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.calendar_today_outlined),
//               label: "Calendar",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person_outline),
//               label: "Profile",
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // 3. Updated the list builder to accept and apply the filter
//   Widget _buildTaskList(String filterStatus) {
//     // Filter logic: If 'All', return everything. Otherwise, match the status.
//     final filteredTasks = filterStatus == 'All'
//         ? _allTasks
//         : _allTasks.where((task) => task['status'] == filterStatus).toList();
//
//     // Show a placeholder if a specific tab has no tasks
//     if (filteredTasks.isEmpty) {
//       return Center(
//         child: Text(
//           "No $filterStatus tasks",
//           style: AppTextStyles.bodySecondary,
//         ),
//       );
//     }
//
//     return ListView.builder(
//       padding: const EdgeInsets.all(AppSpacing.md),
//       itemCount: filteredTasks.length,
//       itemBuilder: (context, index) {
//         final task = filteredTasks[index];
//         return _buildTaskCard(
//           task['title'],
//           task['description'],
//           task['status'],
//           task['color'],
//         );
//       },
//     );
//   }
//
//   // 4. Updated the Task Card to accept dynamic title and description
//   Widget _buildTaskCard(String title, String description, String status, Color statusColor) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: AppSpacing.md),
//       padding: const EdgeInsets.all(AppSpacing.md),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(AppRadius.sm),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: AppTextStyles.titleMedium.copyWith(fontSize: 14),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             description,
//             style: AppTextStyles.bodySecondary.copyWith(fontSize: 12),
//           ),
//           const SizedBox(height: AppSpacing.md),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: statusColor,
//                   borderRadius: BorderRadius.circular(AppRadius.circular),
//                 ),
//                 child: Text(
//                   status,
//                   style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Row(
//                 children: [
//                   Icon(Icons.edit_square, color: AppColors.primary, size: 20),
//                   const SizedBox(width: AppSpacing.sm),
//                   Icon(Icons.delete, color: AppColors.error, size: 20),
//                 ],
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }


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
    _fetchTasks("All"); // Fetch all tasks initially
  }

  Future<void> _fetchTasks(String status) async {
    setState(() {
      _isLoading = true;
    });

    // If status is 'All', you can fetch a specific endpoint or handle it based on your sir's API rules.
    // Usually, the API takes statuses like 'New', 'Completed', 'Progress', 'Canceled'
    String url = status == 'All'
        ? TMUrls.AllTask('New') // Adjust based on your sir's exact API parameters
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
                  // Map tab index to status expected by the backend
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