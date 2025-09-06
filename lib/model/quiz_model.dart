class Quiz {
  final String question;
  final List<String> options;
  final String correctAnswer;

  Quiz({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    final List<String> incorrectAnswers =
        List<String>.from(json['incorrect_answers']);
    final List<String> allOptions = [
      ...incorrectAnswers,
      json['correct_answer']
    ];
    allOptions.shuffle();

    return Quiz(
      question: json['question'],
      options: allOptions,
      correctAnswer: json['correct_answer'],
    );
  }
}
