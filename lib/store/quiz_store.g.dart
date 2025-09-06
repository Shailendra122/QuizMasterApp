// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$QuizStore on QuizStoreBase, Store {
  Computed<bool>? _$isQuizCompletedComputed;

  @override
  bool get isQuizCompleted =>
      (_$isQuizCompletedComputed ??= Computed<bool>(() => super.isQuizCompleted,
              name: 'QuizStoreBase.isQuizCompleted'))
          .value;

  late final _$quizzesAtom =
      Atom(name: 'QuizStoreBase.quizzes', context: context);

  @override
  List<Quiz> get quizzes {
    _$quizzesAtom.reportRead();
    return super.quizzes;
  }

  @override
  set quizzes(List<Quiz> value) {
    _$quizzesAtom.reportWrite(value, super.quizzes, () {
      super.quizzes = value;
    });
  }

  late final _$amountAtom =
      Atom(name: 'QuizStoreBase.amount', context: context);

  @override
  int get amount {
    _$amountAtom.reportRead();
    return super.amount;
  }

  @override
  set amount(int value) {
    _$amountAtom.reportWrite(value, super.amount, () {
      super.amount = value;
    });
  }

  late final _$categoryAtom =
      Atom(name: 'QuizStoreBase.category', context: context);

  @override
  int get category {
    _$categoryAtom.reportRead();
    return super.category;
  }

  @override
  set category(int value) {
    _$categoryAtom.reportWrite(value, super.category, () {
      super.category = value;
    });
  }

  late final _$difficultyAtom =
      Atom(name: 'QuizStoreBase.difficulty', context: context);

  @override
  String get difficulty {
    _$difficultyAtom.reportRead();
    return super.difficulty;
  }

  @override
  set difficulty(String value) {
    _$difficultyAtom.reportWrite(value, super.difficulty, () {
      super.difficulty = value;
    });
  }

  late final _$typeAtom = Atom(name: 'QuizStoreBase.type', context: context);

  @override
  String get type {
    _$typeAtom.reportRead();
    return super.type;
  }

  @override
  set type(String value) {
    _$typeAtom.reportWrite(value, super.type, () {
      super.type = value;
    });
  }

  late final _$totalTimeAtom =
      Atom(name: 'QuizStoreBase.totalTime', context: context);

  @override
  String get totalTime {
    _$totalTimeAtom.reportRead();
    return super.totalTime;
  }

  @override
  set totalTime(String value) {
    _$totalTimeAtom.reportWrite(value, super.totalTime, () {
      super.totalTime = value;
    });
  }

  late final _$timePerQuestionAtom =
      Atom(name: 'QuizStoreBase.timePerQuestion', context: context);

  @override
  int get timePerQuestion {
    _$timePerQuestionAtom.reportRead();
    return super.timePerQuestion;
  }

  @override
  set timePerQuestion(int value) {
    _$timePerQuestionAtom.reportWrite(value, super.timePerQuestion, () {
      super.timePerQuestion = value;
    });
  }

  late final _$currentQuestionIndexAtom =
      Atom(name: 'QuizStoreBase.currentQuestionIndex', context: context);

  @override
  int get currentQuestionIndex {
    _$currentQuestionIndexAtom.reportRead();
    return super.currentQuestionIndex;
  }

  @override
  set currentQuestionIndex(int value) {
    _$currentQuestionIndexAtom.reportWrite(value, super.currentQuestionIndex,
        () {
      super.currentQuestionIndex = value;
    });
  }

  late final _$userResponsesAtom =
      Atom(name: 'QuizStoreBase.userResponses', context: context);

  @override
  Map<int, String> get userResponses {
    _$userResponsesAtom.reportRead();
    return super.userResponses;
  }

  @override
  set userResponses(Map<int, String> value) {
    _$userResponsesAtom.reportWrite(value, super.userResponses, () {
      super.userResponses = value;
    });
  }

  late final _$correctAnswersAtom =
      Atom(name: 'QuizStoreBase.correctAnswers', context: context);

  @override
  Map<int, String> get correctAnswers {
    _$correctAnswersAtom.reportRead();
    return super.correctAnswers;
  }

  @override
  set correctAnswers(Map<int, String> value) {
    _$correctAnswersAtom.reportWrite(value, super.correctAnswers, () {
      super.correctAnswers = value;
    });
  }

  late final _$responseTimesAtom =
      Atom(name: 'QuizStoreBase.responseTimes', context: context);

  @override
  Map<int, int> get responseTimes {
    _$responseTimesAtom.reportRead();
    return super.responseTimes;
  }

  @override
  set responseTimes(Map<int, int> value) {
    _$responseTimesAtom.reportWrite(value, super.responseTimes, () {
      super.responseTimes = value;
    });
  }

  late final _$selectedAnswerAtom =
      Atom(name: 'QuizStoreBase.selectedAnswer', context: context);

  @override
  int get selectedAnswer {
    _$selectedAnswerAtom.reportRead();
    return super.selectedAnswer;
  }

  @override
  set selectedAnswer(int value) {
    _$selectedAnswerAtom.reportWrite(value, super.selectedAnswer, () {
      super.selectedAnswer = value;
    });
  }

  late final _$userAnswerAtom =
      Atom(name: 'QuizStoreBase.userAnswer', context: context);

  @override
  String get userAnswer {
    _$userAnswerAtom.reportRead();
    return super.userAnswer;
  }

  @override
  set userAnswer(String value) {
    _$userAnswerAtom.reportWrite(value, super.userAnswer, () {
      super.userAnswer = value;
    });
  }

  late final _$categoryNameAtom =
      Atom(name: 'QuizStoreBase.categoryName', context: context);

  @override
  String get categoryName {
    _$categoryNameAtom.reportRead();
    return super.categoryName;
  }

  @override
  set categoryName(String value) {
    _$categoryNameAtom.reportWrite(value, super.categoryName, () {
      super.categoryName = value;
    });
  }

  late final _$showAnswerAtom =
      Atom(name: 'QuizStoreBase.showAnswer', context: context);

  @override
  bool get showAnswer {
    _$showAnswerAtom.reportRead();
    return super.showAnswer;
  }

  @override
  set showAnswer(bool value) {
    _$showAnswerAtom.reportWrite(value, super.showAnswer, () {
      super.showAnswer = value;
    });
  }

  late final _$timeRemainingAtom =
      Atom(name: 'QuizStoreBase.timeRemaining', context: context);

  @override
  int get timeRemaining {
    _$timeRemainingAtom.reportRead();
    return super.timeRemaining;
  }

  @override
  set timeRemaining(int value) {
    _$timeRemainingAtom.reportWrite(value, super.timeRemaining, () {
      super.timeRemaining = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'QuizStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorAtom = Atom(name: 'QuizStoreBase.error', context: context);

  @override
  String get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$selectedCategoryAtom =
      Atom(name: 'QuizStoreBase.selectedCategory', context: context);

  @override
  String? get selectedCategory {
    _$selectedCategoryAtom.reportRead();
    return super.selectedCategory;
  }

  @override
  set selectedCategory(String? value) {
    _$selectedCategoryAtom.reportWrite(value, super.selectedCategory, () {
      super.selectedCategory = value;
    });
  }

  late final _$difficultyLevelAtom =
      Atom(name: 'QuizStoreBase.difficultyLevel', context: context);

  @override
  String? get difficultyLevel {
    _$difficultyLevelAtom.reportRead();
    return super.difficultyLevel;
  }

  @override
  set difficultyLevel(String? value) {
    _$difficultyLevelAtom.reportWrite(value, super.difficultyLevel, () {
      super.difficultyLevel = value;
    });
  }

  late final _$questionTypeAtom =
      Atom(name: 'QuizStoreBase.questionType', context: context);

  @override
  String? get questionType {
    _$questionTypeAtom.reportRead();
    return super.questionType;
  }

  @override
  set questionType(String? value) {
    _$questionTypeAtom.reportWrite(value, super.questionType, () {
      super.questionType = value;
    });
  }

  late final _$selectedTimerAtom =
      Atom(name: 'QuizStoreBase.selectedTimer', context: context);

  @override
  String? get selectedTimer {
    _$selectedTimerAtom.reportRead();
    return super.selectedTimer;
  }

  @override
  set selectedTimer(String? value) {
    _$selectedTimerAtom.reportWrite(value, super.selectedTimer, () {
      super.selectedTimer = value;
    });
  }

  late final _$numberOfQuestionsAtom =
      Atom(name: 'QuizStoreBase.numberOfQuestions', context: context);

  @override
  double get numberOfQuestions {
    _$numberOfQuestionsAtom.reportRead();
    return super.numberOfQuestions;
  }

  @override
  set numberOfQuestions(double value) {
    _$numberOfQuestionsAtom.reportWrite(value, super.numberOfQuestions, () {
      super.numberOfQuestions = value;
    });
  }

  late final _$totalTimePerQuestionAtom =
      Atom(name: 'QuizStoreBase.totalTimePerQuestion', context: context);

  @override
  int get totalTimePerQuestion {
    _$totalTimePerQuestionAtom.reportRead();
    return super.totalTimePerQuestion;
  }

  @override
  set totalTimePerQuestion(int value) {
    _$totalTimePerQuestionAtom.reportWrite(value, super.totalTimePerQuestion,
        () {
      super.totalTimePerQuestion = value;
    });
  }

  late final _$themeModeAtom =
      Atom(name: 'QuizStoreBase.themeMode', context: context);

  @override
  ThemeMode get themeMode {
    _$themeModeAtom.reportRead();
    return super.themeMode;
  }

  @override
  set themeMode(ThemeMode value) {
    _$themeModeAtom.reportWrite(value, super.themeMode, () {
      super.themeMode = value;
    });
  }

  late final _$fetchQuizzesAsyncAction =
      AsyncAction('QuizStoreBase.fetchQuizzes', context: context);

  @override
  Future<void> fetchQuizzes() {
    return _$fetchQuizzesAsyncAction.run(() => super.fetchQuizzes());
  }

  late final _$QuizStoreBaseActionController =
      ActionController(name: 'QuizStoreBase', context: context);

  @override
  void toggleTheme() {
    final _$actionInfo = _$QuizStoreBaseActionController.startAction(
        name: 'QuizStoreBase.toggleTheme');
    try {
      return super.toggleTheme();
    } finally {
      _$QuizStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTheme(ThemeMode mode) {
    final _$actionInfo = _$QuizStoreBaseActionController.startAction(
        name: 'QuizStoreBase.setTheme');
    try {
      return super.setTheme(mode);
    } finally {
      _$QuizStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setQuizConfig(
      {required int amount,
      required int category,
      required String categoryName,
      required String difficulty,
      required String type,
      required String totalTime,
      required int timePerQuestion}) {
    final _$actionInfo = _$QuizStoreBaseActionController.startAction(
        name: 'QuizStoreBase.setQuizConfig');
    try {
      return super.setQuizConfig(
          amount: amount,
          category: category,
          categoryName: categoryName,
          difficulty: difficulty,
          type: type,
          totalTime: totalTime,
          timePerQuestion: timePerQuestion);
    } finally {
      _$QuizStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void startTimer() {
    final _$actionInfo = _$QuizStoreBaseActionController.startAction(
        name: 'QuizStoreBase.startTimer');
    try {
      return super.startTimer();
    } finally {
      _$QuizStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void stopTimer() {
    final _$actionInfo = _$QuizStoreBaseActionController.startAction(
        name: 'QuizStoreBase.stopTimer');
    try {
      return super.stopTimer();
    } finally {
      _$QuizStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void recordResponseTime(int questionIndex, int timeInSeconds) {
    final _$actionInfo = _$QuizStoreBaseActionController.startAction(
        name: 'QuizStoreBase.recordResponseTime');
    try {
      return super.recordResponseTime(questionIndex, timeInSeconds);
    } finally {
      _$QuizStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetQuestionTimer() {
    final _$actionInfo = _$QuizStoreBaseActionController.startAction(
        name: 'QuizStoreBase.resetQuestionTimer');
    try {
      return super.resetQuestionTimer();
    } finally {
      _$QuizStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedCategory(String? value) {
    final _$actionInfo = _$QuizStoreBaseActionController.startAction(
        name: 'QuizStoreBase.setSelectedCategory');
    try {
      return super.setSelectedCategory(value);
    } finally {
      _$QuizStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDifficultyLevel(String value) {
    final _$actionInfo = _$QuizStoreBaseActionController.startAction(
        name: 'QuizStoreBase.setDifficultyLevel');
    try {
      return super.setDifficultyLevel(value);
    } finally {
      _$QuizStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setQuestionType(String value) {
    final _$actionInfo = _$QuizStoreBaseActionController.startAction(
        name: 'QuizStoreBase.setQuestionType');
    try {
      return super.setQuestionType(value);
    } finally {
      _$QuizStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedTimer(String? value) {
    final _$actionInfo = _$QuizStoreBaseActionController.startAction(
        name: 'QuizStoreBase.setSelectedTimer');
    try {
      return super.setSelectedTimer(value);
    } finally {
      _$QuizStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNumberOfQuestions(double value) {
    final _$actionInfo = _$QuizStoreBaseActionController.startAction(
        name: 'QuizStoreBase.setNumberOfQuestions');
    try {
      return super.setNumberOfQuestions(value);
    } finally {
      _$QuizStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void startTimerForCurrentQuestion() {
    final _$actionInfo = _$QuizStoreBaseActionController.startAction(
        name: 'QuizStoreBase.startTimerForCurrentQuestion');
    try {
      return super.startTimerForCurrentQuestion();
    } finally {
      _$QuizStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void handleQuestionTimeout() {
    final _$actionInfo = _$QuizStoreBaseActionController.startAction(
        name: 'QuizStoreBase.handleQuestionTimeout');
    try {
      return super.handleQuestionTimeout();
    } finally {
      _$QuizStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void nextQuestion() {
    final _$actionInfo = _$QuizStoreBaseActionController.startAction(
        name: 'QuizStoreBase.nextQuestion');
    try {
      return super.nextQuestion();
    } finally {
      _$QuizStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetStore() {
    final _$actionInfo = _$QuizStoreBaseActionController.startAction(
        name: 'QuizStoreBase.resetStore');
    try {
      return super.resetStore();
    } finally {
      _$QuizStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
quizzes: ${quizzes},
amount: ${amount},
category: ${category},
difficulty: ${difficulty},
type: ${type},
totalTime: ${totalTime},
timePerQuestion: ${timePerQuestion},
currentQuestionIndex: ${currentQuestionIndex},
userResponses: ${userResponses},
correctAnswers: ${correctAnswers},
responseTimes: ${responseTimes},
selectedAnswer: ${selectedAnswer},
userAnswer: ${userAnswer},
categoryName: ${categoryName},
showAnswer: ${showAnswer},
timeRemaining: ${timeRemaining},
isLoading: ${isLoading},
error: ${error},
selectedCategory: ${selectedCategory},
difficultyLevel: ${difficultyLevel},
questionType: ${questionType},
selectedTimer: ${selectedTimer},
numberOfQuestions: ${numberOfQuestions},
totalTimePerQuestion: ${totalTimePerQuestion},
themeMode: ${themeMode},
isQuizCompleted: ${isQuizCompleted}
    ''';
  }
}
