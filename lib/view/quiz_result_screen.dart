import 'package:flutter/material.dart';
import 'package:quizmasterapp/model/quiz_model.dart';
import 'package:quizmasterapp/services/service_locator.dart';
import 'package:quizmasterapp/store/quiz_store.dart';
import 'package:quizmasterapp/utils/app_constants.dart';
import 'package:quizmasterapp/utils/app_sizes.dart';
import 'package:quizmasterapp/utils/colors.dart';
import 'package:quizmasterapp/view/start_page.dart';
import 'package:quizmasterapp/view/start_quiz_page.dart';
import 'package:quizmasterapp/widget/app_scaffold.dart';

class QuizResultsScreen extends StatelessWidget {
  final int totalQuestions;
  final List<Quiz> quizzes;
  final Map<int, String> userResponses;
  final Map<int, String> correctAnswers;
  final Map<int, int> responseTimes;

  const QuizResultsScreen({
    super.key,
    required this.totalQuestions,
    required this.quizzes,
    required this.userResponses,
    required this.correctAnswers,
    required this.responseTimes,
  });

  @override
  Widget build(BuildContext context) {
    final store = getIt<QuizStore>();

    int score = 0;
    for (int i = 0; i < quizzes.length; i++) {
      final user = userResponses[i];
      final correct = correctAnswers[i];
      if (user != null && correct != null && user == correct) {
        score++;
      }
    }

    final List<int> times = responseTimes.values.where((t) => t >= 0).toList();
    final int fastestResponse =
        times.isEmpty ? 0 : times.reduce((a, b) => a < b ? a : b);
    final int slowestResponse =
        times.isEmpty ? 0 : times.reduce((a, b) => a > b ? a : b);
    final double averageTime =
        times.isEmpty ? 0 : times.reduce((a, b) => a + b) / times.length;
    final int totalTime = times.isEmpty ? 0 : times.reduce((a, b) => a + b);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          store.resetStore();
          if (context.mounted) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => StartQuizPage()),
              (route) => false,
            );
          }
        }
      },
      child: AppScaffold(
        appBar: AppBar(
          title: Text(
            "Quiz Results",
            style: TextStyle(color: AppColors.getBodyTextColor(context)),
          ),
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(color: AppColors.getBodyTextColor(context)),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(AppSizes.dp(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildResultSummary(context, score, totalQuestions, totalTime),
              SizedBox(height: AppSizes.dp(20)),
              _buildQuestionReview(context),
              SizedBox(height: AppSizes.dp(20)),
              _buildPerformanceStats(
                context,
                fastestResponse,
                slowestResponse,
                averageTime,
              ),
            ],
          ),
        ),
        bottomButton: Padding(
          padding: EdgeInsets.all(AppSizes.dp(12)),
          child: ElevatedButton(
            onPressed: () {
              store.resetStore();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => StartPage()),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonBackground,
              foregroundColor: AppColors.buttonForeground,
              padding: EdgeInsets.symmetric(
                vertical: AppSizes.dp(15),
                horizontal: AppSizes.dp(30),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  AppSizes.dp(30),
                ),
              ),
            ),
            child: Text(
              'Home',
              style: TextStyle(fontSize: AppSizes.sp(12)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultSummary(
      BuildContext context, int score, int totalQuestions, int totalTime) {
    final percent = totalQuestions > 0
        ? (score / totalQuestions * 100).toStringAsFixed(0)
        : "0";

    return Container(
      padding: EdgeInsets.all(AppSizes.dp(16)),
      decoration: BoxDecoration(
        color: AppColors.getCardColor(context),
        borderRadius: BorderRadius.circular(AppSizes.dp(12)),
      ),
      child: Column(
        children: [
          Text(
            "$percent%",
            style: TextStyle(
              fontSize: AppSizes.sp(32),
              fontWeight: FontWeight.bold,
              color: AppColors.primaryBlue,
            ),
          ),
          SizedBox(height: AppSizes.dp(8)),
          Text(
            score >= totalQuestions * 0.8
                ? AppConstants.greatJobMessage
                : AppConstants.goodEffortMessage,
            style: TextStyle(
              fontSize: AppSizes.sp(20),
              fontWeight: FontWeight.bold,
              color: AppColors.getHeadingTextColor(context),
            ),
          ),
          SizedBox(height: AppSizes.dp(8)),
          Text(
            "You scored $score out of $totalQuestions questions correctly",
            style: TextStyle(color: AppColors.getBodyTextColor(context)),
          ),
          SizedBox(height: AppSizes.dp(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Time Taken: ${_formatSecondsAsMmSs(totalTime)}",
                style: TextStyle(color: AppColors.getBodyTextColor(context)),
              ),
              Text(
                "Total Points: ${score * AppConstants.numericTen}",
                style: TextStyle(
                    fontSize: AppSizes.sp(12),
                    color: AppColors.getHeadingTextColor(context)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionReview(BuildContext context) {
    if (quizzes.isEmpty) {
      return const Center(child: Text("No data available."));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Question Review",
          style: TextStyle(
            fontSize: AppSizes.sp(18),
            fontWeight: FontWeight.bold,
            color: AppColors.getHeadingTextColor(context),
          ),
        ),
        SizedBox(height: AppSizes.dp(10)),
        ...List.generate(quizzes.length, (index) {
          final quiz = quizzes[index];
          final userAnswer = userResponses.containsKey(index)
              ? userResponses[index]!
              : 'Not Selected';
          final correctAnswer = correctAnswers.containsKey(index)
              ? correctAnswers[index]!
              : quiz.correctAnswer;
          final isCorrect = userAnswer == correctAnswer;
          final timeTaken =
              responseTimes.containsKey(index) ? responseTimes[index]! : 0;

          return _buildQuestionTile(
            question: quiz.question,
            userAnswer: userAnswer,
            correctAnswer: correctAnswer,
            isCorrect: isCorrect,
            timeTaken: timeTaken > 0 ? _formatSecondsAsMmSs(timeTaken) : "N/A",
            context: context,
          );
        }),
      ],
    );
  }

  Widget _buildQuestionTile({
    required String question,
    required String userAnswer,
    required String correctAnswer,
    required bool isCorrect,
    required String timeTaken,
    required BuildContext context,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSizes.dp(10)),
      padding: EdgeInsets.all(AppSizes.dp(12)),
      decoration: BoxDecoration(
        color: isCorrect
            ? AppColors.getReviewCorrectBackground(context)
            : AppColors.getReviewWrongBackground(context),
        borderRadius: BorderRadius.circular(AppSizes.dp(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Question: $question",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.getHeadingTextColor(context),
            ),
          ),
          SizedBox(height: AppSizes.dp(8)),
          Text(
            "Your Answer: $userAnswer",
            style: TextStyle(
              color: isCorrect
                  ? AppColors.getReviewCorrectText(context)
                  : AppColors.getReviewWrongText(context),
            ),
          ),
          SizedBox(height: AppSizes.dp(8)),
          Text(
            "Correct Answer: $correctAnswer",
            style: TextStyle(color: AppColors.getReviewCorrectText(context)),
          ),
          SizedBox(height: AppSizes.dp(8)),
          Text(
            "Time taken: $timeTaken",
            style: TextStyle(
                fontSize: AppSizes.sp(12),
                color: AppColors.getBodyTextColor(context)),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceStats(BuildContext context, int fastestResponse,
      int slowestResponse, double averageTime) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Performance Stats",
          style: TextStyle(
            fontSize: AppSizes.sp(18),
            fontWeight: FontWeight.bold,
            color: AppColors.getHeadingTextColor(context),
          ),
        ),
        SizedBox(height: AppSizes.dp(10)),
        _buildStatRow(
            "Average Time per Question",
            averageTime.isFinite
                ? "${averageTime.toStringAsFixed(1)} seconds"
                : "N/A",
            context),
        _buildStatRow(
            "Fastest Response",
            fastestResponse == 0
                ? "N/A"
                : _formatSecondsAsMmSs(fastestResponse),
            context),
        _buildStatRow(
            "Slowest Response",
            slowestResponse == 0
                ? "N/A"
                : _formatSecondsAsMmSs(slowestResponse),
            context),
      ],
    );
  }

  Widget _buildStatRow(String label, String value, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.dp(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: AppColors.getBodyTextColor(context)),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.getHeadingTextColor(context),
            ),
          ),
        ],
      ),
    );
  }

  String _formatSecondsAsMmSs(int seconds) {
    if (seconds <= 0) return "N/A";
    final mins = seconds ~/ 60;
    final secs = seconds % 60;
    if (mins > 0) {
      final s = secs.toString().padLeft(2, '0');
      return "$mins:$s min";
    } else {
      return "$secs seconds";
    }
  }
}
