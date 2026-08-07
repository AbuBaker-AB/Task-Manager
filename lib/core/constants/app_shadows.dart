import 'package:flutter/material.dart';

class AppShadows {
  AppShadows._();

  // Standard card shadow
  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color(0x14000000), // ~8% black
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
  ];

  // Dialog shadow
  static const List<BoxShadow> dialog = [
    BoxShadow(
      color: Color(0x1F000000), // ~12% black
      blurRadius: 20,
      offset: Offset(0, 8),
    ),
  ];

  // Floating Action Button shadow
  static const List<BoxShadow> fab = [
    BoxShadow(
      color: Color(0x26000000), // ~15% black
      blurRadius: 16,
      offset: Offset(0, 6),
    ),
  ];
}