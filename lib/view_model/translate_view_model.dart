import 'package:flutter/material.dart';
import 'package:polylingo/services/translate_service.dart';

class TranslateViewModel extends ChangeNotifier {
  final TranslateService _service;

  TranslateViewModel({required TranslateService service}) : _service = service;

  String _translationResult = '';
  String _explanationResult = '';
  final String _fromSelectedLanguage = 'Japanese';
  final String _toSelectedLanguage = 'English';
  final TextEditingController _textEditingController = TextEditingController();

  String get translationResult => _translationResult;
  String get explanationResult => _explanationResult;
  String get fromSelectedLanguage => _fromSelectedLanguage;
  String get toSelectedLanguage => _toSelectedLanguage;

  Future<void> translate() async {
    final inputText = _textEditingController.text;

    _translationResult = await _service.translateText(
        text: inputText, toSelectedLanguage: toSelectedLanguage);

    ChangeNotifier();
  }

  Future<void> explain() async {
    _explanationResult = await _service.explainText(
        translationResult: translationResult,
        fromSelectedLanguage: fromSelectedLanguage);

    ChangeNotifier();
  }
}
