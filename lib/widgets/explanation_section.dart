import 'package:flutter/material.dart';

class ExplanationSection extends StatelessWidget {
  const ExplanationSection({
    super.key,
    required this.explanationResult,
  });

  final String explanationResult;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
