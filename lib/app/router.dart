import 'package:flutter/material.dart';

import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/email_verification_screen.dart';
import '../features/auth/screens/pin_verification_screen.dart';
import '../features/auth/screens/set_password_screen.dart';
import '../features/auth/screens/signup_screen.dart';
import '../features/home/all_tasks_screen.dart';
import '../features/categories/categories_screen.dart';
import '../features/tasks/add_task_screen.dart';
import '../features/profile/profile_screen.dart';
import '../features/calendar/calendar_screen.dart';
import '../features/splash/splash_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

      case '/login':
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );

      case '/email-verification':
        return MaterialPageRoute(
          builder: (_) => const EmailVerificationScreen(),
        );

      case '/pin-verification':
        return MaterialPageRoute(
          builder: (_) => const PinVerificationScreen(),
        );

      case '/set-password':
        return MaterialPageRoute(
          builder: (_) => const SetPasswordScreen(),
        );

      case '/signup':
        return MaterialPageRoute(
          builder: (_) => const SignupScreen(),
        );

      case '/all-tasks':
        return MaterialPageRoute(
          builder: (_) => const AllTasksScreen(),
        );

      case '/categories':
        return MaterialPageRoute(
          builder: (_) => const CategoriesScreen(),
        );

      case '/add-task':
        return MaterialPageRoute(
          builder: (_) => const AddTaskScreen(),
        );

      case '/profile':
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        );

      case '/calendar':
        return MaterialPageRoute(
          builder: (_) => const CalendarScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Page Not Found'),
            ),
          ),
        );
    }
  }
}