import 'package:flutter/material.dart';

class TranslationButton extends StatelessWidget {
  final VoidCallback onPressed;

  const TranslationButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.lightBlueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      icon: const Icon(Icons.language),
      label: const Text('Translate'),
      onPressed: onPressed,
    );
  }
}
