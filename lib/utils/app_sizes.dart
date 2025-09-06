import 'dart:math';
import 'package:flutter/material.dart';

class AppSizes {
  static late MediaQueryData _mediaQueryData;

  // Initialize the utility with a BuildContext
  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
  }

  static double h(num value) => value * _mediaQueryData.size.height / 100;
  static double w(num value) => value * _mediaQueryData.size.width / 100;

  static double dp(num value) {
    final screenWidth = _mediaQueryData.size.width;
    final screenHeight = _mediaQueryData.size.height;
    final scaleFactor = min(screenWidth / 390, screenHeight / 844);
    return value * scaleFactor;
  }

  static double sp(num value) {
    final textScaler = _mediaQueryData.textScaler;
    return textScaler.scale(value.toDouble());
  }
}