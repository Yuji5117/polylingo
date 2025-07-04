import 'package:flutter/material.dart';
import 'package:polylingo/models/explanation_result.dart';
import 'package:polylingo/models/translation_result.dart';
import 'package:polylingo/services/translate_service.dart';

class TranslateViewModel extends ChangeNotifier {
  final List<String> languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Japanese',
    'Chinese',
    'Korean',
  ];

  final TranslateService _service;

  String _translationResult = '';
  String _explanationResult = '';
  String _fromSelectedLanguage = 'Japanese';
  String _toSelectedLanguage = 'English';
  String? errorMessage;

  final TextEditingController _textEditingController = TextEditingController();

  String get translationResult => _translationResult;
  String get explanationResult => _explanationResult;
  String get fromSelectedLanguage => _fromSelectedLanguage;
  String get toSelectedLanguage => _toSelectedLanguage;
  TextEditingController get textEditingController => _textEditingController;

  TranslateViewModel({required TranslateService service}) : _service = service;

  void onFromLanguageChanged(String? newValue) {
    if (newValue == null) return;

    _fromSelectedLanguage = newValue;
    notifyListeners();
  }

  void onToLanguageChanged(String? newValue) {
    if (newValue == null) return;

    _toSelectedLanguage = newValue;
    notifyListeners();
  }

  void swapLanguages() {
    final temp = fromSelectedLanguage;
    _fromSelectedLanguage = toSelectedLanguage;
    _toSelectedLanguage = temp;
    notifyListeners();
  }

  Future<void> translate() async {
    final inputText = _textEditingController.text;

    try {
      errorMessage = null;

      final json = await _service.translateText(
          text: inputText, toSelectedLanguage: toSelectedLanguage);

      final result = TranslationResult.fromJson(json);
      _translationResult = result.translated;
    } catch (e) {
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> explain() async {
    final json = await _service.explainText(
        translationResult: translationResult,
        fromSelectedLanguage: fromSelectedLanguage);

    final result = ExplanationResult.fromJson(json);

    _explanationResult = result.explanation;
    notifyListeners();
  }
}
