class AppConstants {
  // App-related constants
  static const String appName = "QuizMaster";
  static const String appVersion = "1.0.0";
  static const String appHeaderText = "Quiz Master";
  static const String appSubHeaderText = "Test Your Knowledge!";
  static const String quizText = "Choose Your Quiz";
  static const String quizText2 =
      "Select from various topics and difficulty levels to challenge yourself";
  static const String next = "Next";
  static const String setupQuiz = "Setup Quiz";
  static const String lightModeTooltipText = "Switch to Light Mode";
  static const String darkModeTooltipText = "Switch to Dark Mode";
  static const String selectTopicText = "Select Topic";
  static const String noOfQuestionsText = "Number of Questions";
  static const String difficultyLevelText = "Difficulty Level";
  static const String questionTypesText = "Question Types";
  static const String timerPerQuestionText = "Time Per Question";
  static const String startQuizText = "Start Quiz";
  static const String pleaseFillAllFieldsText = 'Please fill all fields';
  static const String failedToStartQuizText = 'Failed to start quiz: ';

  // Quiz-related constants
  static const int defaultCategoryId = 9;
  static const int defaultTimerSeconds = 30;
  static const int defaultTimePerQuestion =
      30; // Default time per question in seconds
  static const int maxQuestions = 50; // Maximum number of questions allowed
  static const int numericTen = 10;

  static const List<String> quizCategories = [
    'General Knowledge',
    'Science',
    'Sports',
    'Art',
    'Mythology',
    'Vehicles',
    'Animals'
  ];

  static const List<String> difficultyLevels = ['Easy', 'Medium', 'Hard'];
  static const List<String> questionTypes = [
    'Multiple Choice (MCQ)',
    'True/False'
  ];

  // Quiz Category Map
  static const Map<String, int> quizCategoryMap = {
    'General Knowledge': 9,
    'Science': 17,
    'Sports': 21,
    'Mythology': 20,
    'Animals': 27,
    'Vehicles': 28,
    'Art': 25,
  };

  static const Map<String, String> questionTypeMap = {
    'Multiple Choice (MCQ)': 'multiple',
    'True/False': 'boolean'
  };

  static const Map<String, int> timerOptionsInSeconds = {
    '15 seconds': 15,
    '30 seconds': 30,
    '1 minute': 60,
    '2 minutes': 120,
    '5 minutes': 300,
  };

  // Timer-related constants
  static const Duration countdownDuration =
      Duration(seconds: 30); // Default timer duration
  static const String timeRemainingText = "Time Remaining: ";

  // Error Messages
  static const String errorFetchingQuizzes =
      "Error fetching quizzes. Please try again.";
  static const String noQuizzesAvailable = "No quizzes available.";

  // Button Labels
  static const String submitButtonText = "Submit";
  static const String nextButtonText = "Next";
  static const String viewResultsButtonText = "View Results";

  // Result Messages
  static const String greatJobMessage = "Great Job!";
  static const String goodEffortMessage = "Good Effort!";
}
