import 'package:catalog/abstract_services/auth_service.dart';
import 'package:catalog/entities/user.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _service;
  User? currentUser;
  String? errorMessage;

  AuthProvider(this._service);

  Future<void> signIn(String username, String pwd) async {
    final response = await _service.signIn(username: username, pwd: pwd);
    if (response is SuccessResponse) {
      currentUser = User(token: response.token, username: username);
    }
    if (response is FailureResponse) {
      errorMessage = response.message;
    }
    notifyListeners();
  }

  Future<void> signUp(String username, String pwd) async {
    final response = await _service.signUp(username: username, pwd: pwd);
    if (response is SuccessResponse) {
      currentUser = User(token: response.token, username: username);
    }
    notifyListeners();
  }

  signOut() {
    currentUser = null;
    notifyListeners();
  }
}
