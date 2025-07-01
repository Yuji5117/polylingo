import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:polylingo/widgets/language_dropdown.dart';

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
    final response = await http.post(Uri.parse(apiKey!),
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
      translationResult = decodedResponse['translated'];
    });
  }

  Future<void> _explainText(String translationResult) async {
    final apiKey = dotenv.env['TRANSLATION_API_KEY'];
    final response = await http.post(Uri.parse(apiKey!),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'text': translationResult,
          'language': fromSelectedLanguage,
          'contentType': 'explanation',
        }));

    setState(() {
      explanationResult = response.body;
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
              TextField(
                controller: _textEditingController,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Type the text to translate',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  icon: const Icon(Icons.language),
                  label: const Text('Translate'),
                  onPressed: _translateText,
                ),
              ),
              const SizedBox(height: 30),
              if (translationResult.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Translation',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blueAccent)),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        translationResult,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 20),
              if (translationResult.isNotEmpty)
                ActionChip(
                    label: const Text("Explanation"),
                    onPressed: () {
                      _explainText(translationResult);
                    }),
              const SizedBox(height: 20),
              if (explanationResult.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Explanation',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blueAccent)),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        explanationResult,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
