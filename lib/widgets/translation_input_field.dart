import 'package:flutter/material.dart';

class TranslationInputField extends StatelessWidget {
  const TranslationInputField({
    super.key,
    required TextEditingController textEditingController,
  }) : _textEditingController = textEditingController;

  final TextEditingController _textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextField(
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
    );
  }
}
