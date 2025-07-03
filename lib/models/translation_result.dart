class TranslationResult {
  final String translated;

  TranslationResult({required this.translated});

  factory TranslationResult.fromJson(Map<String, dynamic> json) {
    return TranslationResult(translated: json["data"]["translated"] as String);
  }
}
