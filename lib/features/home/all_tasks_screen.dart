import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../api/api_caller.dart';
import '../../api/urls.dart';
import '../tasks/models/task_model.dart';

class AllTasksScreen extends StatefulWidget {
  const AllTasksScreen({super.key});

  @override
  State<AllTasksScreen> createState() => _AllTasksScreenState();
}

class _AllTasksScreenState extends State<AllTasksScreen> {

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

    if (!mounted) return;

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

  Future<void> _updateTaskStatus(String taskId, String newStatus) async {
    final response = await ApiCaller.getRequest(
      URL: TMUrls.updateTask(taskId, newStatus),
    );

    if (!mounted) return;

    if (response.isSuccess) {
      _fetchTasks("All");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update status')),
      );
    }
  }

  void _showStatusUpdateDialog(TaskModel task) {
    String selectedStatus = task.status ?? 'New';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change Status'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return DropdownButton<String>(
                value: ['New', 'Progress', 'Completed', 'Cancelled'].contains(selectedStatus)
                    ? selectedStatus
                    : 'New',
                isExpanded: true,
                items: ['New', 'Progress', 'Completed', 'Cancelled']
                    .map((status) => DropdownMenuItem(
                  value: status,
                  child: Text(status),
                ))
                    .toList(),
                onChanged: (newVal) {
                  if (newVal != null) {
                    setState(() {
                      selectedStatus = newVal;
                    });
                  }
                },
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _updateTaskStatus(task.sId ?? '', selectedStatus);
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        title: const Text(
          "All Tasks",
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md, horizontal: AppSpacing.md),
            child: Row(
              children: [
                _buildSummaryCard("09", "All Tasks"),
                _buildSummaryCard("09", "Pending"),
                _buildSummaryCard("09", "In Progress"),
                _buildSummaryCard("09", "Completed"),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.sm),

          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _taskList.isEmpty
                ? const Center(child: Text("No tasks found"))
                : ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: _taskList.length,
              itemBuilder: (context, index) {
                return _buildTaskCard(_taskList[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.pushNamed(context, '/add-task');
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
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
            label: "Profile",
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String count, String label) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              )
            ]
        ),
        child: Column(
          children: [
            Text(
              count,
              style: AppTextStyles.headingMedium.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTextStyles.caption.copyWith(fontSize: 10),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskCard(TaskModel task) {
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
          Text(task.title ?? '', style: AppTextStyles.titleMedium.copyWith(fontSize: 14)),
          const SizedBox(height: 4),
          Text(task.description ?? '', style: AppTextStyles.bodySecondary.copyWith(fontSize: 12)),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  _showStatusUpdateDialog(task);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(task.status ?? ''),
                    borderRadius: BorderRadius.circular(AppRadius.circular),
                  ),
                  child: Text(
                    task.status ?? '',
                    style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit_square, color: AppColors.primary, size: 20),
                    onPressed: () {
                    },
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  IconButton(
                    icon: Icon(Icons.delete, color: AppColors.error, size: 20),
                    onPressed: () async {
                      bool? confirm = await _showDeleteConfirmation(context);
                      if (confirm == true) {
                        final response = await ApiCaller.getRequest(
                          URL: TMUrls.deleteTask(task.sId ?? ''),
                        );
                        if (response.isSuccess) {
                          _fetchTasks("All");
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Failed to delete task')),
                          );
                        }
                      }
                    },
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'progress':
      case 'in progress':
        return Colors.blue;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Future<bool?> _showDeleteConfirmation(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete', style: TextStyle(color: Colors.red))),
        ],
      ),
    );
  }
}