class CustomError {
  final String message;

  CustomError([this.message = '']);

  @override
  String toString() => message;
}

class NetworkError extends CustomError {
  NetworkError([String message = 'A network error occurred']) : super(message);
}

class ServerError extends CustomError {
  ServerError([String message = 'A server error occurred']) : super(message);
}

class CacheError extends CustomError {
  CacheError([String message = 'A cache error occurred']) : super(message);
}

class AuthenticationError extends CustomError {
  AuthenticationError([String message = 'Authentication failed'])
      : super(message);
}

class UnknownError extends CustomError {
  UnknownError([String message = 'An unknown error occurred']) : super(message);
}

CustomError exceptionToError(dynamic e, [String? message]) {
  switch (e.runtimeType) {
    case CacheError:
      return CacheError(message ??
          'Failed to get user data from cache. Please try again later.');
    case AuthenticationError:
      return AuthenticationError(
          message ?? 'Invalid credentials. Please try again.');
    default:
      return UnknownError(
          message ?? 'An unexpected error occurred. Please try again later.');
  }
}
