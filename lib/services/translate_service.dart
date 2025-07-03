import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class TranslateService {
  final String? apiKey = dotenv.env['TRANSLATION_API_KEY'];

  Future<String> translateText(
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
      final decodedResponse = jsonDecode(response.body);
      return decodedResponse['data']['translated'];
    } else {
      throw Exception('Failed to translate text: ${response.body}');
    }
  }
}
