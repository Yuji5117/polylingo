import 'package:flutter/material.dart';

class ExplanationButton extends StatelessWidget {
  final bool canExplain;
  final VoidCallback onPressed;

  const ExplanationButton({
    super.key,
    required this.canExplain,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: canExplain ? onPressed : null,
      icon: const Icon(Icons.info_outline),
      label: const Text("Explain"),
      style: ElevatedButton.styleFrom(
        backgroundColor: canExplain ? Colors.blueAccent : Colors.grey.shade300,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
