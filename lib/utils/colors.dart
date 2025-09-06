import 'package:flutter/material.dart';

class AppColors {
  // Theme-aware color getters
  static Color getHeadingTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkHeadingText
        : headingText;
  }

  static Color getBodyTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : bodyText;
  }

  static Color getIconColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkIconColor
        : iconColor;
  }

  static Color getButtonColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? surfaceDark
        : buttonBackground;
  }

  static Color getCardBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? cardDark
        : Colors.white;
  }

  static Color getAnswerCardBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromARGB(255, 82, 73, 73)
        : Colors.white;
  }

  static Color getSelectedButtonBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? selectedButtonBackgroundDark
        : selectedButtonBackground;
  }

  static Color getAnswerSelectedButtonBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Color(0xff525252)
        : selectedButtonBackground;
  }

  static Color getAnswerSelectedTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromARGB(255, 30, 56, 152)
        : Colors.grey;
  }

  static Color getUnselectedButtonBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? unselectedButtonBackgroundDark
        : unselectedButtonBackground;
  }

  static Color getSelectedButtonTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? selectedButtonTextDark
        : selectedButtonText;
  }

  static Color getUnselectedButtonTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? unselectedButtonTextDark
        : unselectedButtonText;
  }

  static Color getSectionBackground(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? backgroundDark
          : primaryWhite;

  static Color getDropdownBackground(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? dropdownBackgroundDark
          : dropdownBackground;

  static Color getSelectedButtonText(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : selectedButtonText;

  static Color getUnselectedButtonText(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.white70
          : unselectedButtonText;

  static Color getCardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? cardDark
        : primaryWhite;
  }

  static Color getCorrectOptionBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromARGB(255, 14, 226, 21)
        : correctOptionBackground;
  }

  static Color getWrongOptionBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromARGB(255, 226, 32, 14)
        : wrongOptionBackground;
  }

  static Color getAnswerOptionBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromARGB(255, 82, 73, 73)
        : wrongOptionBackground;
  }

  static Color getCorrectAnswerIconColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.green;
  }

  static Color getWrongAnswerIconColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.red;
  }

  static Color getDifficultyBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Color(0xff262626)
        : difficultyBackground;
  }

  static Color getDifficultyTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Color(0xff4ade80)
        : Colors.green;
  }

  // Add theme-aware answer backgrounds for question review
  static Color getReviewCorrectBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? cardDark // blue-grey dark
        : const Color(0xFFE8F5E9); // light green
  }

  static Color getReviewWrongBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? cardDark // muted dark red
        : const Color(0xFFFFEBEE); // light red
  }

  static Color getReviewCorrectText(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromARGB(255, 22, 192, 96) // teal accent
        : Colors.green;
  }

  static Color getReviewWrongText(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Color(0xffdc2626) // soft orange
        : Colors.red;
  }

  static Color getStartingIconColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Color.fromARGB(255, 234, 231, 231) // soft orange
        : iconColor;
  }

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Primary Colors (unchanged)
  static const Color primaryBlue = Color.fromARGB(255, 95, 54, 208);
  static const Color primaryWhite = Colors.white;
  static const Color lightBlue = Colors.blue;
  static const Color textColor = Color.fromARGB(255, 9, 9, 9);

  // Background Colors (only dark mode changed)
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const backgroundDark = Color(0xFF181818); // lighter and richer dark bg
  static const Color surfaceDark = Color(0xFF242424); // darker card surface

  // Text Colors (dark mode improved)
  static const Color headingText = Color.fromARGB(255, 26, 24, 24);
  static const Color bodyText = Color(0xFF757575);
  static const Color successText = Colors.green;
  static const Color errorText = Colors.red;
  static const Color darkBodyText =
      Color(0xFFCCCCCC); // lighter for better contrast
  static const Color darkHeadingText = Colors.white;

  // Icon Colors (unchanged)
  static const Color iconColor = Color.fromARGB(255, 43, 1, 135);
  static const Color darkIconColor = Colors.white;

  // Button Colors (unchanged for light, updated dark)
  static const Color buttonBackground = Color(0xff4f46e5);
  static const Color buttonForeground = Color(0xffffffff);

  // Dropdown and Input Colors (dark mode updated)
  static const Color dropdownBackground = Colors.white;
  static const Color dropdownBackgroundDark = Color(0xFF1C1C1C);
  static const Color dropdownBorder = Color(0xFFCCCCCC);
  static const Color dropdownBorderDark = Colors.white24;
  static const Color dropdownHintText = Color(0xFF9E9E9E);
  static const Color dropdownHintTextDark = Colors.white54;

  // Slider Colors (dark mode updated)
  static const Color sliderActiveTrack = Color.fromARGB(255, 121, 110, 245);
  static const Color sliderInactiveTrack = Color(0xFFE0E0E0);
  static const Color sliderThumb = Color.fromARGB(255, 73, 20, 221);

  static const Color sliderActiveTrackDark = Colors.blueAccent;
  static const Color sliderInactiveTrackDark = Colors.white30;
  static const Color sliderThumbDark = Colors.blueAccent;

  // Section Title Colors (unchanged)
  static const Color sectionTitle = Color.fromARGB(255, 26, 24, 24);

  // Selected/Unselected Button Colors (light unchanged)
  static const Color selectedButtonBackground = Color(0xffeef2ff);
  static const Color unselectedButtonBackground = Color(0xFFf3f4f6);
  static const Color selectedButtonText = Color(0xff4338ca);
  static const Color unselectedButtonText = Color(0xff374151);

  // Selected/Unselected Button Colors (dark mode updated)
  static const selectedButtonBackgroundDark = Color(0xFF375FC9); // softer blue
  static const unselectedButtonBackgroundDark =
      Color.fromRGBO(44, 44, 44, 0.85); // semi-transparent dark
  static const Color selectedButtonTextDark = Colors.white;
  static const unselectedButtonTextDark = Color(0xD9FFFFFF);
  // brighter unselected text

  // Result-Specific Colors (unchanged)
  static const Color correctAnswerBackground = Color(0xFFE8F5E9);
  static const Color wrongAnswerBackground = Color(0xFFFFEBEE);
  static const Color statRowBackground = Color(0xFFEEEEEE);

  // Quiz Screen Specific Colors (unchanged)
  static const Color timeRemainingText = Colors.red;
  static const Color progressIndicatorBackground = Color(0xFFE0E0E0);
  static const Color progressIndicatorValue = Color.fromARGB(255, 73, 20, 221);
  static const Color categoryText = Color.fromARGB(255, 10, 112, 228);
  static const Color questionNumberText = Color.fromARGB(255, 14, 14, 14);
  static const Color difficultyBackground = Color(0xFFE8F5E9);
  static const Color answerOptionBackground = Colors.white;
  static const Color selectedOptionBackground = Color(0xFFB3E5FC);
  static const Color correctOptionBackground = Color(0xFFE8F5E9);
  static const Color wrongOptionBackground = Color(0xFFFFEBEE);

  // Gradient Colors (unchanged)
  static const Color primaryGradientStart = Color(0xFF9105E8);
  static const Color primaryGradientEnd = Color(0xFF370679);

  static const cardDark = Color(0xFF242424); // lighter card for dark mode
  static const bodyTextDark = Colors.white70;
  static const headingTextDark = Colors.white;
}
