import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppColors {
  static const Color primary = Colors.green;
  static const Color accent = Colors.orange;
  static const Color error = Colors.red;
  static const Color background = Colors.white;
}

class AppTextStyles {
  static TextStyle title = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static TextStyle subtitle = TextStyle(
    fontSize: 16.sp,
    color: AppColors.accent,
  );

  static TextStyle error = TextStyle(
    fontSize: 14.sp,
    color: AppColors.error,
  );
}
