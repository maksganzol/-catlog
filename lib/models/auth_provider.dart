import 'package:catalog/abstract_services/auth_service.dart';
import 'package:catalog/entities/user.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _service;
  User? currentUser;

  AuthProvider(this._service);

  Future<void> signIn(String username, String pwd) async {
    final response = await _service.signIn(username: username, pwd: pwd);
    if (response is SuccessResponse) {
      currentUser = User(token: response.token, username: username);
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
    print('Sign OUT');
    currentUser = null;
    notifyListeners();
  }
}
