class AuthResponse {
  static AuthResponse fromMap(Map<String, dynamic> map) {
    if (map['success']) return SuccessResponse(map['token']);
    return FailureResponse(map['message']);
  }
}

class SuccessResponse extends AuthResponse {
  final String token;
  SuccessResponse(this.token);
}

class FailureResponse extends AuthResponse {
  final String message;

  FailureResponse(this.message);
}

abstract class AuthService {
  Future<AuthResponse> signIn({required String username, required String pwd});
  Future<AuthResponse> signUp({required String username, required String pwd});
}
