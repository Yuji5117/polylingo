import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:polylingo/widgets/explanation_section.dart';
import 'package:polylingo/widgets/language_dropdown.dart';
import 'package:polylingo/widgets/translation_button.dart';
import 'package:polylingo/widgets/translation_input_field.dart';
import 'package:polylingo/widgets/translation_section.dart';

class TranslationScreen extends StatefulWidget {
  const TranslationScreen({super.key, required this.title});

  final String title;

  @override
  State<TranslationScreen> createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final List<String> languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Japanese',
    'Chinese',
    'Korean',
  ];

  String fromSelectedLanguage = 'Japanese';
  String toSelectedLanguage = 'English';
  String translationResult = '';
  String explanationResult = '';

  Future<void> _translateText() async {
    final apiKey = dotenv.env['TRANSLATION_API_KEY'];
    final response = await http.post(Uri.parse('$apiKey/translate'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'text': _textEditingController.text,
          'to': toSelectedLanguage,
          'contentType': 'translation',
        }));

    final Map<String, dynamic> decodedResponse = jsonDecode(response.body);

    setState(() {
      translationResult = decodedResponse['data']['translated'];
    });
  }

  Future<void> _explainText(String translationResult) async {
    final apiKey = dotenv.env['TRANSLATION_API_KEY'];
    final response = await http.post(Uri.parse('$apiKey/translate/explain'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'text': translationResult,
          'from': fromSelectedLanguage,
          'contentType': 'explanation',
        }));

    final Map<String, dynamic> decodedResponse = jsonDecode(response.body);

    setState(() {
      explanationResult = decodedResponse['data']['explanation'];
    });
  }

  void _onFromLanguageChanged(String? newValue) {
    if (newValue == null) return;

    setState(() {
      fromSelectedLanguage = newValue;
    });
  }

  void _onToLanguageChanged(String? newValue) {
    if (newValue == null) return;

    setState(() {
      toSelectedLanguage = newValue;
    });
  }

  void _swapLanguages() {
    setState(() {
      final temp = fromSelectedLanguage;
      fromSelectedLanguage = toSelectedLanguage;
      toSelectedLanguage = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F5FF),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: LanguageDropdown(
                        languages: languages,
                        selectedLanguage: fromSelectedLanguage,
                        onChanged: _onFromLanguageChanged),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                      onPressed: _swapLanguages,
                      icon: const Icon(Icons.swap_horiz)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: LanguageDropdown(
                        languages: languages,
                        selectedLanguage: toSelectedLanguage,
                        onChanged: _onToLanguageChanged),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              TranslationInputField(
                  textEditingController: _textEditingController),
              const SizedBox(height: 20),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: TranslationButton(onPressed: _translateText)),
              const SizedBox(height: 30),
              if (translationResult.isNotEmpty)
                TranslationSection(translationResult: translationResult),
              const SizedBox(height: 20),
              if (translationResult.isNotEmpty)
                ActionChip(
                    label: const Text("Explanation"),
                    onPressed: () {
                      _explainText(translationResult);
                    }),
              const SizedBox(height: 20),
              if (explanationResult.isNotEmpty)
                ExplanationSection(explanationResult: explanationResult),
            ],
          ),
        ),
      ),
    );
  }
}
