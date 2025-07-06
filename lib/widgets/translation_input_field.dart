import 'package:flutter/material.dart';

class TranslationInputField extends StatelessWidget {
  final TextEditingController _textEditingController;
  final String? errorText;

  const TranslationInputField(
      {super.key,
      required TextEditingController textEditingController,
      this.errorText})
      : _textEditingController = textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      maxLines: null,
      decoration: InputDecoration(
        hintText: 'Type the text to translate',
        filled: true,
        fillColor: Colors.white,
        errorText: errorText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
