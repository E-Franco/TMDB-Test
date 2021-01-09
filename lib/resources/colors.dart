import 'package:flutter/painting.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF171e35);
  static Color accentColor = HSLColor.fromColor(primaryColor).withLightness(0.2).toColor();
  static Color lightBlue = HSLColor.fromColor(primaryColor).withLightness(0.3).toColor();
}
