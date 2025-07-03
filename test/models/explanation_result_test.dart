import 'package:flutter_test/flutter_test.dart';
import 'package:polylingo/models/explanation_result.dart';

void main() {
  group('ExplanationResult', () {
    test('fromJson should parse correctly', () {
      final json = {
        'data': {'explanation': 'この文は、気分がいい時に会話でよく使われます。'}
      };

      final reslut = ExplanationResult.fromJson(json);

      expect(reslut.explanation, 'この文は、気分がいい時に会話でよく使われます。');
    });
  });
}
