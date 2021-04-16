import 'package:catalog/models/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Action {
  signin,
  signup,
}

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<Login> {
  Action _currentAction = Action.signin;

  Widget _buildStyledButton(String text, Function() onPressed) => TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      );

  Widget _buildSubmitButton(Function() onSignIn, Function() onSignUp) =>
      _currentAction == Action.signin
          ? _buildStyledButton('Sign in', onSignIn)
          : _buildStyledButton('Sign up', onSignUp);

  Widget _buildNavButton() => _currentAction == Action.signin
      ? TextButton(
          onPressed: () => setState(() => _currentAction = Action.signup),
          child: Text('Sign up'),
        )
      : TextButton(
          onPressed: () => setState(() => _currentAction = Action.signin),
          child: Text('Back to sign in'),
        );

  @override
  Widget build(BuildContext context) {
    final _usernameCon = TextEditingController();
    final _pwdCon = TextEditingController();

    final authProvider = Provider.of<AuthProvider>(context);
    if (authProvider.currentUser != null) Navigator.of(context).pop();

    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (authProvider.errorMessage != null)
                Text(
                  authProvider.errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              TextFormField(controller: _usernameCon),
              TextFormField(controller: _pwdCon, obscureText: true),
              _buildSubmitButton(
                () => authProvider.signIn(_usernameCon.text, _pwdCon.text),
                () => authProvider.signUp(_usernameCon.text, _pwdCon.text),
              ),
              _buildNavButton(),
            ],
          ),
        ),
      ),
    );
  }
}
