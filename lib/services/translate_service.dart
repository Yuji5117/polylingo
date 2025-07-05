import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:polylingo/exceptions/app_exception.dart';

class TranslateService {
  final String? apiKey = dotenv.env['TRANSLATION_API_KEY'];

  Future<Map<String, dynamic>> translateText(
      {required String text, required String toSelectedLanguage}) async {
    final uri = Uri.parse('$apiKey/translate');

    try {
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
      } else if (response.statusCode == 400) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final Map<String, String> errors =
            Map<String, String>.from(json['errors']);
        throw ValidationException(errors);
      } else {
        throw const ServerException();
      }
    } on TimeoutException {
      throw const TimeoutAppException();
    } on SocketException {
      throw const NetworkException();
    } on AppException {
      rethrow;
    } catch (e, stack) {
      debugPrint('Unexpected error: $e\n$stack');
      throw const UnknownException();
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
