class ApiExceptions implements Exception {
  final String message;
  final int? statusCode;

  ApiExceptions({
    required this.message,
    this.statusCode,
  });
}

class GeneralExption implements Exception {
  final String message;
  GeneralExption({
    this.message = 'por favor tente novamente',
  });
}

class AudioplayerException implements Exception {
  final String message;
  AudioplayerException({required this.message});
}
