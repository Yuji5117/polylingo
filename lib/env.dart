import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static final String apiKey = dotenv.env['API_KEY'] ?? '';
  static final String translationApiKey =
      dotenv.env['TRANSLATION_API_KEY'] ?? '';
}
