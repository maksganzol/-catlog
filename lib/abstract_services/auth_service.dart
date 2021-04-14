class AuthResponse {
  static AuthResponse fromMap(Map<String, dynamic> map) {
    if (map['success']) return SuccessResponse(map['token']);
    return FailureResponse();
  }
}

class SuccessResponse extends AuthResponse {
  final String token;
  SuccessResponse(this.token);
}

class FailureResponse extends AuthResponse {}

abstract class AuthService {
  Future<AuthResponse> signIn({String username, String pwd});
  Future<AuthResponse> signUp({String username, String pwd});
}
