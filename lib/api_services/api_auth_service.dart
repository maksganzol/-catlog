import 'dart:convert';

import 'package:catalog/abstract_services/auth_service.dart';
import 'package:catalog/api_services/api.dart';
import 'package:http/http.dart' as http;

String formBody(String username, String pwd) => jsonEncode({
      'username': username,
      'password': pwd,
    });

class ApiAuthService implements AuthService {
  final API _api;

  ApiAuthService(this._api);

  Future<T> _post<T>(String path, String username, String pwd) => http
      .post(_api.endpoint(path),
          headers: {
            'Keep-Alive': 'timeout=5, max=1000',
            'Content-Type': 'application/json'
          },
          body: jsonEncode({
            'username': username,
            'password': pwd,
          }))
      .then((response) => jsonDecode(response.body));

  @override
  Future<AuthResponse> signIn({
    required String username,
    required String pwd,
  }) =>
      _post<Map<String, dynamic>>('login/', username, pwd)
          .then(AuthResponse.fromMap);

  @override
  Future<AuthResponse> signUp({
    required String username,
    required String pwd,
  }) =>
      _post<Map<String, dynamic>>('register/', username, pwd)
          .then(AuthResponse.fromMap);
}
