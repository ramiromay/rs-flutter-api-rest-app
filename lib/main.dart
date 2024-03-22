import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_api_rest/helpers/dependency_injection.dart';
import 'package:flutter_api_rest/pages/home_page.dart';
import 'package:flutter_api_rest/pages/login_page.dart';
import 'package:flutter_api_rest/pages/register_page.dart';
import 'package:flutter_api_rest/pages/splash_page.dart';

void main() {
  DependencyInjection.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashPage(),
      routes: {
        RegisterPage.routeName : (_) => RegisterPage(),
        LoginPage.routeName : (_) => LoginPage(),
        HomePage.routeName : (_) => HomePage(),
      },
    );
  }
}


