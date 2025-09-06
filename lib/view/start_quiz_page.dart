import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:quizmasterapp/store/quiz_store.dart';
import 'package:quizmasterapp/utils/app_constants.dart';
import 'package:quizmasterapp/utils/app_sizes.dart';
import 'package:quizmasterapp/view/quiz_screen.dart';
import 'package:quizmasterapp/services/service_locator.dart';
import 'package:quizmasterapp/utils/colors.dart';
import 'package:quizmasterapp/widget/app_scaffold.dart';

class StartQuizPage extends StatefulWidget {
  const StartQuizPage({super.key});

  @override
  State<StartQuizPage> createState() => _StartQuizPageState();
}

class _StartQuizPageState extends State<StartQuizPage> {
  final store = getIt<QuizStore>();

  @override
  void initState() {
    super.initState();
    store.resetStore();
  }

  int getCategoryID(String category) {
    return AppConstants.quizCategoryMap[category] ??
        AppConstants.defaultCategoryId;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppScaffold(
      appBar: AppBar(
        title: Text(
          AppConstants.setupQuiz,
          style: TextStyle(
            color: AppColors.getHeadingTextColor(context),
          ),
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        iconTheme: IconThemeData(
          color: AppColors.getIconColor(context),
        ),
        elevation: 0,
        actions: [
          Observer(
            builder: (_) => IconButton(
              icon: Icon(
                store.themeMode == ThemeMode.dark
                    ? Icons.wb_sunny
                    : Icons.nightlight_round,
              ),
              tooltip: store.themeMode == ThemeMode.dark
                  ? AppConstants.lightModeTooltipText
                  : AppConstants.darkModeTooltipText,
              onPressed: () => store.toggleTheme(),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.dp(10)),
        child: Container(
          margin: EdgeInsets.all(AppSizes.dp(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection(
                title: AppConstants.selectTopicText,
                child: Observer(builder: (context) {
                  return _buildDropdown(
                    value: store.selectedCategory,
                    hint: 'Select',
                    items: AppConstants.quizCategories,
                    onChanged: (newValue) => store.selectedCategory = newValue,
                  );
                }),
              ),
              SizedBox(height: AppSizes.dp(12)),
              _buildSection(
                title: AppConstants.noOfQuestionsText,
                child: Observer(builder: (context) {
                  return Column(
                    children: [
                      Slider(
                        value: store.numberOfQuestions,
                        min: 1,
                        max: 50,
                        divisions: 49,
                        activeColor: AppColors.sliderActiveTrack,
                        inactiveColor: AppColors.sliderInactiveTrack,
                        thumbColor: AppColors.sliderThumb,
                        label: store.numberOfQuestions.round().toString(),
                        onChanged: (value) => store.numberOfQuestions = value,
                      ),
                      SizedBox(height: AppSizes.dp(8)),
                      Text(
                        "Selected: ${store.numberOfQuestions.round()}",
                        style: TextStyle(
                          fontSize: AppSizes.sp(16),
                          fontWeight: FontWeight.w600,
                          color: AppColors.getBodyTextColor(context),
                        ),
                      ),
                    ],
                  );
                }),
              ),
              SizedBox(height: AppSizes.dp(16)),
              _buildSection(
                title: AppConstants.difficultyLevelText,
                child: Observer(
                  builder: (_) {
                    final selected = store.difficultyLevel;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: AppConstants.difficultyLevels.map((level) {
                        final bool isSelected = selected == level;
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppSizes.dp(4)),
                            child: _buildChoiceButton(
                              label: level,
                              isSelected: isSelected,
                              onPressed: () => store.difficultyLevel = level,
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
              SizedBox(height: AppSizes.dp(16)),
              _buildSection(
                title: AppConstants.questionTypesText,
                child: Observer(builder: (context) {
                  return Column(
                    children: AppConstants.questionTypes
                        .map((type) => Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: AppSizes.dp(4),
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                child: _buildChoiceButton(
                                  label: type,
                                  isSelected: store.questionType == type,
                                  onPressed: () => store.questionType = type,
                                ),
                              ),
                            ))
                        .toList(),
                  );
                }),
              ),
              SizedBox(height: AppSizes.dp(8)),
              _buildSection(
                title: AppConstants.timerPerQuestionText,
                child: _buildDropdown(
                  value: store.selectedTimer,
                  hint: 'Select Timer',
                  items: AppConstants.timerOptionsInSeconds.keys.toList(),
                  onChanged: (newValue) {
                    store.selectedTimer = newValue;
                    store.totalTimePerQuestion =
                        AppConstants.timerOptionsInSeconds[newValue] ??
                            AppConstants.defaultTimerSeconds;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomButton: Padding(
        padding: EdgeInsets.all(AppSizes.dp(8)),
        child: ElevatedButton(
          onPressed: _startQuiz,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.buttonBackground,
            foregroundColor: AppColors.buttonForeground,
            padding: EdgeInsets.symmetric(
              vertical: AppSizes.dp(15),
              horizontal: AppSizes.dp(30),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.dp(30)),
            ),
          ),
          child: Text(
            AppConstants.startQuizText,
            style: TextStyle(
              fontSize: AppSizes.sp(15),
            ),
          ),
        ),
      ),
    );
  }

  void _startQuiz() {
    if ([
      store.selectedCategory,
      store.difficultyLevel,
      store.questionType,
      store.selectedTimer
    ].contains(null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppConstants.pleaseFillAllFieldsText,
            style: TextStyle(color: AppColors.getBodyTextColor(context)),
          ),
          backgroundColor: Theme.of(context).snackBarTheme.backgroundColor ??
              Theme.of(context).colorScheme.surface,
        ),
      );
      return;
    }

    try {
      store.setQuizConfig(
        amount: store.numberOfQuestions.round(),
        category: getCategoryID(store.selectedCategory!),
        categoryName: store.selectedCategory!,
        difficulty: store.difficultyLevel!.toLowerCase(),
        type: AppConstants.questionTypeMap[store.questionType] ?? 'multiple',
        totalTime: store.selectedTimer.toString(),
        timePerQuestion: store.totalTimePerQuestion,
      );

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const QuizScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${AppConstants.failedToStartQuizText} $e')),
      );
    }
  }

  Widget _buildDropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.dp(8)),
          borderSide: BorderSide(color: AppColors.dropdownBorder),
        ),
        filled: true,
        fillColor: AppColors.getDropdownBackground(context),
      ),
      dropdownColor: AppColors.getDropdownBackground(context),
      hint: Text(
        hint,
        style: TextStyle(color: AppColors.getBodyTextColor(context)),
      ),
      iconEnabledColor: AppColors.getIconColor(context),
      style: TextStyle(color: AppColors.getBodyTextColor(context)),
      onChanged: onChanged,
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Container(
      padding: EdgeInsets.all(AppSizes.dp(8)),
      decoration: BoxDecoration(
        color: AppColors.getCardColor(context),
        borderRadius: BorderRadius.all(
          Radius.circular(AppSizes.dp(16)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: AppSizes.sp(12),
              fontWeight: FontWeight.bold,
              color: AppColors.getHeadingTextColor(context),
            ),
          ),
          SizedBox(height: AppSizes.dp(8)),
          child,
        ],
      ),
    );
  }

  Widget _buildChoiceButton({
    required String label,
    required VoidCallback onPressed,
    required bool isSelected,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.dp(8)),
        ),
        backgroundColor: isSelected
            ? AppColors.getSelectedButtonBackground(context)
            : AppColors.getUnselectedButtonBackground(context),
        foregroundColor: isSelected
            ? AppColors.getSelectedButtonText(context)
            : AppColors.getUnselectedButtonText(context),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: AppSizes.sp(12)),
        textAlign: TextAlign.center,
      ),
    );
  }
}
