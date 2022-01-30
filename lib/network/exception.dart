class AppException implements Exception {
  final dynamic message;
  final String prefix;
  final String url;

  AppException(this.message, this.prefix, this.url);

  String toString() {
    return "$prefix$message";
  }
}

class NetworkException extends AppException {
  NetworkException(String message, String url)
      : super(message, "No internet connection", url);
}

class FetchDataException extends AppException {
  FetchDataException(String message, String url)
      : super(message, "FetchDataExceptions", url);
}

class ApiNotRespondingException extends AppException {
  ApiNotRespondingException([String? message, String? url])
      : super(message, "API not responding", url!);
}

class BadRequestException extends AppException {
  BadRequestException([String? message, String? url])
      : super(message, "BadRequestException", url!);
}

class UnauthorisedException extends AppException {
  UnauthorisedException([String? message, String? url]) : super(message, "", url!);
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message, String? url])
      : super(message, "InvalidInputException", url!);
}
