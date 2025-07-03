import 'package:flutter_test/flutter_test.dart';
import 'package:polylingo/models/translation_result.dart';

void main() {
  group('TranslationResult', () {
    test("fromJson should parse correctly", () {
      final json = {
        'data': {'translated': 'Hello'}
      };

      final result = TranslationResult.fromJson(json);

      expect(result.translated, 'Hello');
    });
  });
}
