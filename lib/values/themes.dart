import 'package:flutter/material.dart';

TextTheme buildTextTheme(TextTheme base) {
  return base.copyWith(
    displayLarge: base.displayLarge?.copyWith(
      fontWeight: FontWeight.w500,
      color: Colors.grey.shade800,
    ),
    titleLarge: base.titleLarge?.copyWith(fontSize: 18.0),
    bodySmall: base.bodySmall?.copyWith(
      fontWeight: FontWeight.w400,
      color: Colors.grey.shade600,
      fontSize: 14.0,
    ),
    bodyMedium: base.bodyMedium?.copyWith(
      fontWeight: FontWeight.w500,
      color: Colors.grey.shade800,
      fontSize: 16.0,
    ),
  );
}











