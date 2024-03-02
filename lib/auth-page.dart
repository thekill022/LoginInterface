import 'package:flutter/material.dart';
import 'package:logininterface/login-page.dart';
import 'package:logininterface/register-page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;

  void Togglescreen() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return Login(ShowRegisteredPage: Togglescreen);
    } else {
      return Register(showLoginPage: Togglescreen);
    }
  }
}
