import 'package:flutter/material.dart';

class TranslationSection extends StatelessWidget {
  const TranslationSection({
    super.key,
    required this.translationResult,
  });

  final String translationResult;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
