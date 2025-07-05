import 'package:polylingo/constants/error_messages.dart';

abstract class AppException implements Exception {
  final String message;
  const AppException(this.message);

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  const NetworkException() : super(ErrorMessages.network);
}

class TimeoutAppException extends AppException {
  const TimeoutAppException() : super(ErrorMessages.timeout);
}

class ServerException extends AppException {
  const ServerException() : super(ErrorMessages.server);
}

class UnknownException extends AppException {
  const UnknownException() : super(ErrorMessages.unknown);
}

class ValidationException extends AppException {
  final Map<String, String> fieldErrors;
  const ValidationException(this.fieldErrors) : super(ErrorMessages.validation);
}
