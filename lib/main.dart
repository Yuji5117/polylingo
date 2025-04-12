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
      home: TranslationScreen(title: 'Polylingo'),
    );
  }
}

class TranslationScreen extends StatefulWidget {
  TranslationScreen({super.key, required this.title});

  final String title;

  @override
  State<TranslationScreen> createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  String translationResult = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                labelText: 'Type the text to translate',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  final apiKey = dotenv.env['TRANSLATION_API_KEY'];
                  final response = await http.get(Uri.parse(apiKey!));
                  setState(() {
                    translationResult = response.body;
                  });
                },
                child: const Text("Translate")),
            Text(
              translationResult,
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ));
  }
}
