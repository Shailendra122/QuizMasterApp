import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'dart:async';
import 'package:quizmasterapp/services/service_locator.dart';
import 'package:quizmasterapp/store/quiz_store.dart';
import 'package:quizmasterapp/utils/app_constants.dart';
import 'package:quizmasterapp/utils/app_sizes.dart';
import 'package:quizmasterapp/view/quiz_result_screen.dart';
import 'package:quizmasterapp/utils/colors.dart';
import 'package:quizmasterapp/view/start_quiz_page.dart';
import 'package:quizmasterapp/widget/answer_option_widget.dart';
import 'package:quizmasterapp/widget/app_scaffold.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  final store = getIt<QuizStore>();
  late Timer _questionTimer;
  int _currentQuestionTimeRemaining = 30;
  late DateTime questionStartTime;
  List<String>? shuffledAnswers;
  bool _answerSubmitted = false;

  @override
  void initState() {
    super.initState();
    _currentQuestionTimeRemaining = store.timePerQuestion;
    if (store.quizzes.isEmpty) {
      store.fetchQuizzes();
    }
    questionStartTime = DateTime.now();
    startQuestionTimer();
    noQuizzesAvailableFunc();
  }

  @override
  void dispose() {
    try {
      _questionTimer.cancel();
    } catch (_) {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          final navigator = Navigator.of(context);

          final shouldExit = await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (dialogCtx) => AlertDialog(
              title: const Text("Exit Quiz?"),
              content: const Text(
                "If you go back now, your quiz will stop and progress will be lost.",
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogCtx).pop(false),
                  child: const Text("No"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(dialogCtx).pop(true),
                  child: const Text("Yes"),
                ),
              ],
            ),
          );

          if (shouldExit == true) {
            store.resetStore();

            navigator.pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const StartQuizPage()),
              (route) => false,
            );
          }
        }
      },
      child: AppScaffold(
        appBar: AppBar(
          title: Text(
            AppConstants.appName,
            style: TextStyle(color: AppColors.getBodyTextColor(context)),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Observer(
          builder: (_) {
            if (store.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (store.error.isNotEmpty) {
              return _errorInQuizWidget();
            }
            if (store.quizzes.isEmpty) {
              return _noQuizAvailable();
            }

            final currentQuiz = store.quizzes[store.currentQuestionIndex];
            shuffledAnswers ??= [...currentQuiz.options]..shuffle();
            final correctAnswerIndex =
                shuffledAnswers!.indexOf(currentQuiz.correctAnswer);

            return Padding(
              padding: EdgeInsets.all(AppSizes.dp(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          _timeRemainingTextWidget(),
                          _timeRemainingCountWidget(),
                        ],
                      ),
                      _questionIndexTextWidget(),
                    ],
                  ),
                  SizedBox(height: AppSizes.dp(10)),
                  _progressIndicator(),
                  SizedBox(height: AppSizes.dp(20)),
                  Container(
                    padding: EdgeInsets.all(AppSizes.dp(12)),
                    decoration: BoxDecoration(
                      color: AppColors.getCardBackground(context),
                      borderRadius: BorderRadius.circular(AppSizes.dp(10)),
                      boxShadow: const [
                        BoxShadow(color: Colors.grey, blurRadius: 4)
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _categoryName(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _questionIndexWidget(),
                            _difficultyTextWidget(),
                          ],
                        ),
                        SizedBox(height: AppSizes.dp(10)),
                        Text(
                          currentQuiz.question,
                          style: TextStyle(
                            fontSize: AppSizes.sp(12),
                            fontWeight: FontWeight.bold,
                            color: AppColors.getHeadingTextColor(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSizes.dp(20)),
                  Column(
                    children: List.generate(shuffledAnswers!.length, (index) {
                      return AnswerOptionWidget(
                        text: shuffledAnswers![index],
                        index: index,
                        isSelected: store.selectedAnswer == index,
                        showAnswer: store.showAnswer,
                        isCorrect: index == correctAnswerIndex,
                        onTap: (_currentQuestionTimeRemaining <= 0 ||
                                store.showAnswer)
                            ? null
                            : () => selectAnswer(index),
                      );
                    }),
                  ),
                  SizedBox(height: AppSizes.dp(20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _submitButton(),
                      if (store.currentQuestionIndex < store.quizzes.length - 1)
                        _lastQuestionSubmitButtonHandle(),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _lastQuestionSubmitButtonHandle() {
    return ElevatedButton(
      onPressed: store.showAnswer
          ? () {
              nextQuestion();
            }
          : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.getButtonColor(context),
        foregroundColor: AppColors.buttonForeground,
        padding: EdgeInsets.symmetric(
          vertical: AppSizes.dp(12),
          horizontal: AppSizes.dp(24),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.dp(8)),
        ),
      ),
      child: const Text('Next'),
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed:
          store.selectedAnswer != -1 && !store.showAnswer ? submitAnswer : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.getButtonColor(context),
        foregroundColor: AppColors.buttonForeground,
        padding: EdgeInsets.symmetric(
          vertical: AppSizes.dp(12),
          horizontal: AppSizes.dp(24),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.dp(8)),
        ),
      ),
      child: const Text('Submit'),
    );
  }

  Widget quizViewResult() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuizResultsScreen(
                totalQuestions: store.quizzes.length,
                quizzes: store.quizzes,
                userResponses: store.userResponses,
                correctAnswers: store.correctAnswers,
                responseTimes: store.responseTimes,
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.getButtonColor(context),
          foregroundColor: AppColors.buttonForeground,
        ),
        child: const Text("View Results"),
      ),
    );
  }

  Widget _noQuizAvailable() {
    return Center(
      child: Text(
        AppConstants.noQuizzesAvailable,
        style: TextStyle(
          fontSize: AppSizes.sp(12),
          color: AppColors.getBodyTextColor(context),
        ),
      ),
    );
  }

  Widget _errorInQuizWidget() {
    return Center(
      child: Text(
        '${AppConstants.errorFetchingQuizzes}: ${store.error}',
        style: TextStyle(
          fontSize: AppSizes.sp(12),
          color: AppColors.getBodyTextColor(context),
        ),
      ),
    );
  }

  Widget _timeRemainingTextWidget() {
    return Text(
      "Time Remaining: ",
      style: TextStyle(color: AppColors.getBodyTextColor(context)),
    );
  }

  Widget _timeRemainingCountWidget() {
    return Text(
      "00:${store.timeRemaining}",
      style: TextStyle(
        color: AppColors.timeRemainingText,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _questionIndexTextWidget() {
    return Text(
      "Question ${store.currentQuestionIndex + 1}/${store.quizzes.length}",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: AppColors.getBodyTextColor(context),
      ),
    );
  }

  Widget _progressIndicator() {
    return LinearProgressIndicator(
      value: store.timeRemaining / store.timePerQuestion,
      backgroundColor: AppColors.progressIndicatorBackground,
      valueColor:
          AlwaysStoppedAnimation<Color>(AppColors.progressIndicatorValue),
    );
  }

  Widget _categoryName() {
    return Text(
      store.categoryName,
      style:
          TextStyle(color: AppColors.categoryText, fontWeight: FontWeight.w700),
    );
  }

  Widget _questionIndexWidget() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.dp(5),
        vertical: AppSizes.dp(5),
      ),
      child: Text(
        '${store.currentQuestionIndex + 1}',
        style: TextStyle(
          color: AppColors.getHeadingTextColor(context),
          fontSize: AppSizes.sp(12),
          fontWeight: FontWeight.w200,
        ),
      ),
    );
  }

  Widget _difficultyTextWidget() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.dp(10),
        vertical: AppSizes.dp(5),
      ),
      decoration: BoxDecoration(
        color: AppColors.getDifficultyBackgroundColor(context),
        borderRadius: BorderRadius.circular(AppSizes.dp(10)),
      ),
      child: Text(
        store.difficulty,
        style: TextStyle(color: AppColors.getDifficultyTextColor(context)),
      ),
    );
  }

  void startQuestionTimer() {
    try {
      _questionTimer.cancel();
    } catch (_) {}
    _currentQuestionTimeRemaining = store.timePerQuestion;
    questionStartTime = DateTime.now();

    _questionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentQuestionTimeRemaining > 0) {
        _currentQuestionTimeRemaining--;
        store.timeRemaining = _currentQuestionTimeRemaining;
      }

      if (_currentQuestionTimeRemaining <= 0) {
        timer.cancel();
        handleQuestionTimeout();
      }
    });
  }

  void handleQuestionTimeout() {
    if (_answerSubmitted) {
      _questionTimer.cancel();
      if (store.currentQuestionIndex >= store.quizzes.length - 1) {
        _goToResults();
      } else {
        _prepareNextQuestion();
      }
      return;
    }

    _answerSubmitted = true;

    _questionTimer.cancel();

    final currentQuiz = store.quizzes[store.currentQuestionIndex];
    final userAnswer = store.selectedAnswer == -1
        ? 'Not Selected'
        : (shuffledAnswers != null
            ? shuffledAnswers![store.selectedAnswer]
            : currentQuiz.options[store.selectedAnswer]);
    final responseTime = DateTime.now().difference(questionStartTime).inSeconds;

    store.submitAnswer(
      questionIndex: store.currentQuestionIndex,
      userAnswer: userAnswer,
      correctAnswer: currentQuiz.correctAnswer,
      responseTime: responseTime,
    );

    if (store.currentQuestionIndex >= store.quizzes.length - 1) {
      _goToResults();
    } else {
      _prepareNextQuestion();
    }
  }

  void selectAnswer(int index) {
    if (_currentQuestionTimeRemaining > 0 && !store.showAnswer) {
      store.selectedAnswer = index;

      store.userAnswer = shuffledAnswers![index].toString();
    }
  }

  void submitAnswer() {
    if (store.selectedAnswer == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select an answer!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_answerSubmitted) return;
    _answerSubmitted = true;

    final currentQuiz = store.quizzes[store.currentQuestionIndex];
    final userAnswer = shuffledAnswers != null
        ? shuffledAnswers![store.selectedAnswer]
        : currentQuiz.options[store.selectedAnswer];
    final responseTime = DateTime.now().difference(questionStartTime).inSeconds;

    store.submitAnswer(
      questionIndex: store.currentQuestionIndex,
      userAnswer: userAnswer,
      correctAnswer: currentQuiz.correctAnswer,
      responseTime: responseTime,
    );

    store.recordResponseTime(store.currentQuestionIndex, responseTime);

    if (store.currentQuestionIndex >= store.quizzes.length - 1) {
      _goToResults();
    }
  }

  void nextQuestion() {
    _answerSubmitted = false;
    final currentQuiz = store.quizzes[store.currentQuestionIndex];
    if (!store.showAnswer) {
      final userAnswer = store.selectedAnswer == -1
          ? 'Not Selected'
          : (shuffledAnswers != null
              ? shuffledAnswers![store.selectedAnswer]
              : currentQuiz.options[store.selectedAnswer]);
      final responseTime =
          DateTime.now().difference(questionStartTime).inSeconds;
      store.submitAnswer(
        questionIndex: store.currentQuestionIndex,
        userAnswer: userAnswer,
        correctAnswer: currentQuiz.correctAnswer,
        responseTime: responseTime,
      );
    }

    if (store.currentQuestionIndex < store.quizzes.length - 1) {
      store.showAnswer = false;
      store.selectedAnswer = -1;
      store.userAnswer = '';
      shuffledAnswers = null;
      store.nextQuestion();
      startQuestionTimer();
      _answerSubmitted = false;
    } else {
      _goToResults();
    }
  }

  void _prepareNextQuestion() {
    _answerSubmitted = false;
    store.showAnswer = false;
    store.selectedAnswer = -1;
    store.userAnswer = '';
    shuffledAnswers = null;
    store.nextQuestion();
    startQuestionTimer();
  }

  void _goToResults() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => QuizResultsScreen(
          totalQuestions: store.quizzes.length,
          quizzes: store.quizzes,
          userResponses: store.userResponses,
          correctAnswers: store.correctAnswers,
          responseTimes: store.responseTimes,
        ),
      ),
      (route) => false,
    );
  }

  void noQuizzesAvailableFunc() {
    if (store.quizzes.isEmpty) {
      if (store.isLoading) {
        Timer(const Duration(seconds: 3), () {
          if (store.quizzes.isEmpty && !store.isLoading) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => StartQuizPage(),
              ),
            );
          }
        });
      }
    }
  }
}
