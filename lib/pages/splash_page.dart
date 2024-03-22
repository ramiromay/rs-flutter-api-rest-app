

import 'package:flutter/material.dart';
import 'package:flutter_api_rest/data/authentication_client.dart';
import 'package:flutter_api_rest/pages/home_page.dart';
import 'package:flutter_api_rest/pages/login_page.dart';
import 'package:get_it/get_it.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  final _authenticationClient = GetIt.instance<AuthenticationClient>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CircularProgressIndicator(),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLogin();
    });
  }

  Future<void> _checkLogin() async {
    final token = await _authenticationClient.accessToken;
    if (token == null) {
      Navigator.pushReplacementNamed(context, LoginPage.routeName);
      return;
    }
    Navigator.pushReplacementNamed(context, HomePage.routeName);
  }

}
