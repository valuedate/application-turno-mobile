class AuthException implements Exception {
  final String msg;

  AuthException({
    required this.msg,
  });

  @override
  String toString() {
    return msg;
  }
}
