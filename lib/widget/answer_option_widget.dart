// answer_option_widget.dart
import 'package:flutter/material.dart';
import 'package:quizmasterapp/utils/app_sizes.dart';
import 'package:quizmasterapp/utils/colors.dart';

class AnswerOptionWidget extends StatelessWidget {
  final String text;
  final int index;
  final bool isSelected;
  final bool showAnswer;
  final bool isCorrect;
  final VoidCallback? onTap;

  const AnswerOptionWidget({
    required this.text,
    required this.index,
    required this.isSelected,
    required this.showAnswer,
    required this.isCorrect,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Determine background color
    Color bgColor;
    if (showAnswer) {
      if (isCorrect) {
        bgColor = AppColors.getCorrectOptionBackground(context);
      } else if (isSelected) {
        bgColor = AppColors.getWrongOptionBackground(context);
      } else {
        bgColor = AppColors.getAnswerOptionBackground(context);
      }
    } else {
      bgColor = isSelected
          ? AppColors.getAnswerSelectedButtonBackground(context)
          : AppColors.getCardBackground(context);
    }

    // Determine border color
    Color borderColor;
    if (showAnswer) {
      if (isCorrect) {
        borderColor = Colors.green;
      } else if (isSelected) {
        borderColor = Colors.red;
      } else {
        borderColor = Colors.grey;
      }
    } else {
      borderColor = Colors.grey;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: AppSizes.dp(5)),
        padding: EdgeInsets.all(AppSizes.dp(16)),
        width: double.infinity,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(AppSizes.dp(10)),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: AppSizes.sp(12),
                  color: AppColors.getBodyTextColor(context),
                ),
                softWrap: true,
                maxLines: 3, // Prevents overflow — safe for long answers
                overflow: TextOverflow.ellipsis, // Fallback for overflow
              ),
            ),
            if (showAnswer)
              Icon(
                isCorrect ? Icons.check : Icons.close,
                color: isCorrect
                    ? AppColors.getCorrectAnswerIconColor(context)
                    : AppColors.getWrongAnswerIconColor(context),
              ),
          ],
        ),
      ),
    );
  }
}
