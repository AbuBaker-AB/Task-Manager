import 'package:flutter/material.dart';

import 'router.dart';
import 'theme.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',

      theme: AppTheme.lightTheme,

      onGenerateRoute: AppRouter.generateRoute,

      initialRoute: '/',
    );
  }
}