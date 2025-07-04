import 'package:flutter/material.dart';
import 'package:polylingo/utils/snackbar_util.dart';
import 'package:provider/provider.dart';
import 'package:polylingo/view_model/translate_view_model.dart';
import 'package:polylingo/widgets/explanation_section.dart';
import 'package:polylingo/widgets/language_selection_row.dart';
import 'package:polylingo/widgets/translation_button.dart';
import 'package:polylingo/widgets/translation_input_field.dart';
import 'package:polylingo/widgets/translation_section.dart';

class TranslationScreen extends StatelessWidget {
  const TranslationScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TranslateViewModel>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (viewModel.errorMessage != null) {
        showErrorSnackbar(context, viewModel.errorMessage!);
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF9F5FF),
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LanguageSelectionRow(
                  languages: viewModel.languages,
                  fromSelectedLanguage: viewModel.fromSelectedLanguage,
                  toSelectedLanguage: viewModel.toSelectedLanguage,
                  onFromLanguageChanged: viewModel.onFromLanguageChanged,
                  onToLanguageChanged: viewModel.onToLanguageChanged,
                  swapLanguages: viewModel.swapLanguages),
              const SizedBox(height: 15),
              TranslationInputField(
                  textEditingController: viewModel.textEditingController),
              const SizedBox(height: 20),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: TranslationButton(onPressed: viewModel.translate)),
              const SizedBox(height: 30),
              if (viewModel.translationResult.isNotEmpty)
                TranslationSection(
                    translationResult: viewModel.translationResult),
              const SizedBox(height: 20),
              if (viewModel.translationResult.isNotEmpty)
                ActionChip(
                    label: const Text("Explanation"),
                    onPressed: () {
                      viewModel.explain();
                    }),
              const SizedBox(height: 20),
              if (viewModel.explanationResult.isNotEmpty)
                ExplanationSection(
                    explanationResult: viewModel.explanationResult),
            ],
          ),
        ),
      ),
    );
  }
}
