import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/quiz_model.dart';

class QuizApi {
  static const String _baseUrl = "https://opentdb.com/api.php";

  Future<List<Quiz>> fetchQuizData({
    required int amount,
    required int category,
    required String difficulty,
    required String type,
  }) async {
    final Uri url = Uri.parse(
      "$_baseUrl?amount=$amount&category=$category&difficulty=$difficulty&type=$type",
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        
        final List<dynamic> results = jsonData['results'];
        return results.map((json) => Quiz.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load quiz data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}