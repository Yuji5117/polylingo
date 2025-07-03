import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class TranslateService {
  final String? apiKey = dotenv.env['TRANSLATION_API_KEY'];

  Future<Map<String, dynamic>> translateText(
      {required String text, required String toSelectedLanguage}) async {
    final uri = Uri.parse('$apiKey/translate');

    final response = await http.post(uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'text': text,
          'to': toSelectedLanguage,
          'contentType': 'translation',
        }));

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return json;
    } else {
      throw Exception('Failed to translate text: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> explainText(
      {required String translationResult,
      required String fromSelectedLanguage}) async {
    final uri = Uri.parse('$apiKey/translate/explain');

    final response = await http.post(uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'text': translationResult,
          'from': fromSelectedLanguage,
          'contentType': 'explanation',
        }));

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return json;
    } else {
      throw Exception('Failed to explain text: ${response.body}');
    }
  }
}
