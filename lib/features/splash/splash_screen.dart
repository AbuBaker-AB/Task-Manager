import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/widgets/app_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 2),
          () {

        if (!mounted) return;

        Navigator.pushReplacementNamed(
          context,
          '/login',
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,

      body: SafeArea(
        child: Stack(

          children: [

            Positioned(

              right: -80,

              bottom: -80,

              child: Container(

                width: 220,

                height: 220,

                decoration: BoxDecoration(

                  shape: BoxShape.circle,

                  border: Border.all(
                    color: AppColors.primary.withOpacity(.05),
                    width: 2,
                  ),

                ),

              ),

            ),

            Center(
              child: const AppLogo(),
            ),

          ],

        ),
      ),
    );
  }
}