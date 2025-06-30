import 'package:flutter/material.dart';

class LanguageDropdown extends StatelessWidget {
  final List<String> languages;
  final String selectedLanguage;
  final ValueChanged<String?> onChanged;

  const LanguageDropdown(
      {super.key,
      required this.languages,
      required this.selectedLanguage,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        child: DropdownButton<String>(
          value: selectedLanguage,
          items: languages.map((String language) {
            return DropdownMenuItem<String>(
                value: language, child: Text(language));
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
