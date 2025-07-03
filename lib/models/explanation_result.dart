class ExplanationResult {
  final String explanation;

  ExplanationResult({required this.explanation});

  factory ExplanationResult.fromJson(Map<String, dynamic> json) {
    return ExplanationResult(explanation: json['data']['explanation']);
  }
}
