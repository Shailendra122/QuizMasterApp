import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../api/quiz_api.dart';
import '../model/quiz_model.dart';

part 'quiz_store.g.dart';

class QuizStore = QuizStoreBase with _$QuizStore;

abstract class QuizStoreBase with Store {
  final QuizApi _quizApi = QuizApi();

  @observable
  List<Quiz> quizzes = [];

  @observable
  int amount = 10;

  @observable
  int category = 9;

  @observable
  String difficulty = "easy";

  @observable
  String type = "multiple";

  @observable
  String totalTime = '120';

  @observable
  int timePerQuestion = 30;

  @observable
  int currentQuestionIndex = 0;

  @observable
  Map<int, String> userResponses = {};

  @observable
  Map<int, String> correctAnswers = {};

  @observable
  Map<int, int> responseTimes = {};

  @observable
  int selectedAnswer = -1;

  @observable
  String userAnswer = '';

  @observable
  String categoryName = 'General Knowledge';

  @observable
  bool showAnswer = false;

  @observable
  int timeRemaining = 30;

  @observable
  bool isLoading = false;

  @observable
  String error = '';

  @observable
  String? selectedCategory;

  @observable
  String? difficultyLevel;

  @observable
  String? questionType;

  @observable
  String? selectedTimer;

  @observable
  double numberOfQuestions = 10;

  @observable
  int totalTimePerQuestion = 30;

  @observable
  ThemeMode themeMode = ThemeMode.dark;

  Timer? _timer;

  @action
  void toggleTheme() {
    themeMode = themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    setTheme(themeMode);
  }

  @action
  void setTheme(ThemeMode mode) {
    themeMode = mode;
  }

  @action
  void setQuizConfig({
    required int amount,
    required int category,
    required String categoryName,
    required String difficulty,
    required String type,
    required String totalTime,
    required int timePerQuestion,
  }) {
    this.amount = amount;
    this.category = category;
    this.categoryName = categoryName;
    this.difficulty = difficulty;
    this.type = type;
    this.totalTime = totalTime;
    this.timePerQuestion = timePerQuestion;

    timeRemaining = timePerQuestion;
  }

  @action
  Future<void> fetchQuizzes() async {
    isLoading = true;
    error = '';
    quizzes.clear();

    try {
      final List<Quiz> fetchedQuizzes = await _quizApi.fetchQuizData(
        amount: amount,
        category: category,
        difficulty: difficulty,
        type: type,
      );

      quizzes = fetchedQuizzes;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  void startTimer() {
    startTimerForCurrentQuestion();
  }

  @action
  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @action
  void recordResponseTime(int questionIndex, int timeInSeconds) {
    responseTimes[questionIndex] = timeInSeconds;
  }

  @computed
  bool get isQuizCompleted =>
      currentQuestionIndex == quizzes.length - 1 &&
      userResponses.length == quizzes.length;

  @action
  void resetQuestionTimer() {
    timeRemaining = timePerQuestion;
  }

  @action
  void setSelectedCategory(String? value) {
    selectedCategory = value;
  }

  @action
  void setDifficultyLevel(String value) {
    difficultyLevel = value;
  }

  @action
  void setQuestionType(String value) {
    questionType = value;
  }

  @action
  void setSelectedTimer(String? value) {
    selectedTimer = value;
    totalTimePerQuestion = timerOptionsInSeconds[value] ?? 30;
  }

  @action
  void setNumberOfQuestions(double value) {
    numberOfQuestions = value;
  }

  final Map<String, int> timerOptionsInSeconds = {
    '15 seconds': 15,
    '30 seconds': 30,
    '1 minute': 60,
    '2 minutes': 120,
    '5 minutes': 300,
  };

  @action
  void startTimerForCurrentQuestion() {
    stopTimer();
    timeRemaining = timePerQuestion;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timeRemaining--;
      if (timeRemaining <= 0) {
        timer.cancel();
        handleQuestionTimeout();
      }
    });
  }

  @action
  void handleQuestionTimeout() {
    if (!showAnswer) {
      final currentQuiz = quizzes[currentQuestionIndex];
      final userAns = selectedAnswer == -1
          ? 'Not Selected'
          : currentQuiz.options[selectedAnswer];
      userResponses[currentQuestionIndex] = userAns;
      correctAnswers[currentQuestionIndex] = currentQuiz.correctAnswer;
      responseTimes[currentQuestionIndex] = timePerQuestion;
      showAnswer = true;
    }

    if (currentQuestionIndex < quizzes.length - 1) {
      nextQuestion();
      startTimerForCurrentQuestion();
    } else {
      stopTimer();
    }
  }

  void submitAnswer({
    required int questionIndex,
    required String userAnswer,
    required String correctAnswer,
    required int responseTime,
  }) {
    userResponses[questionIndex] = userAnswer;
    correctAnswers[questionIndex] = correctAnswer;
    responseTimes[questionIndex] = responseTime;

    showAnswer = true;
  }

  @action
  void nextQuestion() {
    if (currentQuestionIndex < quizzes.length - 1) {
      currentQuestionIndex++;
      selectedAnswer = -1;
      showAnswer = false;
      userAnswer = '';
      timeRemaining = timePerQuestion;
    } else {
      stopTimer();
    }
  }

  @action
  void resetStore() {
    stopTimer();

    quizzes.clear();

    amount = 10;
    category = 9;
    categoryName = 'General Knowledge';
    difficulty = "easy";
    type = "multiple";
    totalTime = '120';
    timePerQuestion = 30;

    isLoading = false;
    error = '';

    userResponses.clear();
    correctAnswers.clear();
    responseTimes.clear();

    currentQuestionIndex = 0;
    selectedAnswer = -1;
    userAnswer = '';
    showAnswer = false;
    timeRemaining = 30;

    selectedCategory = null;
    difficultyLevel = null;
    questionType = null;
    selectedTimer = null;
    numberOfQuestions = 10;
    totalTimePerQuestion = 30;
  }
}
