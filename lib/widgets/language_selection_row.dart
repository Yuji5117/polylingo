import 'package:flutter/material.dart';
import 'package:polylingo/widgets/language_dropdown.dart';

class LanguageSelectionRow extends StatelessWidget {
  final List<String> languages;
  final String fromSelectedLanguage;
  final String toSelectedLanguage;
  final ValueChanged<String?> onFromLanguageChanged;
  final ValueChanged<String?> onToLanguageChanged;
  final VoidCallback swapLanguages;

  const LanguageSelectionRow(
      {super.key,
      required this.languages,
      required this.fromSelectedLanguage,
      required this.toSelectedLanguage,
      required this.onFromLanguageChanged,
      required this.onToLanguageChanged,
      required this.swapLanguages});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: LanguageDropdown(
              languages: languages,
              selectedLanguage: fromSelectedLanguage,
              onChanged: onFromLanguageChanged),
        ),
        const SizedBox(width: 16),
        IconButton(
            onPressed: swapLanguages, icon: const Icon(Icons.swap_horiz)),
        const SizedBox(width: 16),
        Expanded(
          child: LanguageDropdown(
              languages: languages,
              selectedLanguage: toSelectedLanguage,
              onChanged: onToLanguageChanged),
        ),
      ],
    );
  }
}
