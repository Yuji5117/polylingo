import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Polylingo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TranslationScreen(title: 'Polylingo'),
    );
  }
}

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

  String selectedLanguage = 'English';
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
          'language': selectedLanguage,
          'contentType': 'translation',
        }));
    setState(() {
      translationResult = response.body;
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
          'language': selectedLanguage,
          'contentType': 'explanation',
        }));

    setState(() {
      explanationResult = response.body;
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
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButton<String>(
                        value: selectedLanguage,
                        items: languages.map((String language) {
                          return DropdownMenuItem<String>(
                              value: language, child: Text(language));
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedLanguage = newValue!;
                          });
                        })),
              ),
              // 言語選択のドロップダウンメニュー
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
              const SizedBox(height: 20),
              if (translationResult.isNotEmpty)
                ActionChip(
                    label: const Text("Explanation"),
                    onPressed: () {
                      _explainText(translationResult);
                    }),
              const SizedBox(height: 20),
              if (explanationResult.isNotEmpty)
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
        ),
      ),
    );
  }
}
