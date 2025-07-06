import 'package:flutter/material.dart';
import 'package:polylingo/exceptions/app_exception.dart';
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
  Object? error;
  String? translateErrorText;
  String? explanationErrorText;

  final TextEditingController _textEditingController = TextEditingController();

  String get translationResult => _translationResult;
  String get explanationResult => _explanationResult;
  String get fromSelectedLanguage => _fromSelectedLanguage;
  String get toSelectedLanguage => _toSelectedLanguage;
  TextEditingController get textEditingController => _textEditingController;

  bool get canSubmit => _textEditingController.text.trim().isNotEmpty;

  TranslateViewModel({required TranslateService service}) : _service = service {
    _textEditingController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    notifyListeners();
  }

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
      error = null;
      translateErrorText = null;

      final json = await _service.translateText(
          text: inputText, toSelectedLanguage: toSelectedLanguage);

      final result = TranslationResult.fromJson(json);
      _translationResult = result.translated;
    } on ValidationException catch (e) {
      translateErrorText = e.fieldErrors['text'];
      error = e;
    } catch (e) {
      error = e;
    }
    notifyListeners();
  }

  Future<void> explain() async {
    try {
      error = null;
      explanationErrorText = null;

      final json = await _service.explainText(
          translationResult: translationResult,
          fromSelectedLanguage: fromSelectedLanguage);

      final result = ExplanationResult.fromJson(json);

      _explanationResult = result.explanation;
    } on ValidationException catch (e) {
      explanationErrorText = e.fieldErrors['text'];
      error = e;
    } catch (e) {
      error = e;
    }
    notifyListeners();
  }
}
