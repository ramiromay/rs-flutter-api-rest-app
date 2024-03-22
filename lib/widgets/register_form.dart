import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api_rest/api/authentication_api.dart';
import 'package:flutter_api_rest/models/user_register_model.dart';
import 'package:flutter_api_rest/data/authentication_client.dart';
import 'package:flutter_api_rest/pages/home_page.dart';
import 'package:flutter_api_rest/utils/dialogs.dart';
import 'package:flutter_api_rest/utils/responsive.dart';
import 'package:flutter_api_rest/widgets/input_text.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  final GlobalKey<FormState> _formKey = GlobalKey();
  final _authenticationApi = GetIt.instance<AuthenticationApi>();
  final _authenticationClient = GetIt.instance<AuthenticationClient>();
  final Logger _logger = Logger();

  String _email = '';
  String _password = '';
  String _username = '';

  Future<void>_submit() async {
    final bool isOk = _formKey.currentState!.validate();
    if (isOk) {
      ProgressDialog.show(context);
      final response = await _authenticationApi.register(
          userRegister: UserRegisterModel(
              username: _username,
              email: _email,
              password: _password
          ),
      );
      ProgressDialog.dismiss(context);
      if (response.data != null) {
        await _authenticationClient.saveSession(response.data!);
        Navigator.pushNamedAndRemoveUntil(context, HomePage.routeName, (_) => false);
      }
      else {

        String message = response.error!.message;

        if (response.error!.statusCode == -1) {
          message = 'Bad Network';
        }
        else if (response.error!.statusCode == 409) {
          message = 'Duplicate user ${jsonEncode(response.error!.data['duplicatedFields'])}';
        }

        Dialogs.alert(
            context,
            title: 'Error',
            description: message
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Positioned(
      bottom: 30,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: responsive.isTablet ? 430 : 360,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              InputText(
                label: 'USERNAME',
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                onChanged: (text) {
                  _username = text;
                },
                validator: (text) {
                  if (text == null || text.trim().length < 5) {
                    return "invalid usernme";
                  }
                  return null;
                },
              ),
              SizedBox(height: responsive.dp(2)),
              InputText(
                label: 'EMAIL ADDRESS',
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                onChanged: (text) {
                  _email = text;
                },
                validator: (text) {
                  if (text == null || !text.contains("@")) {
                    return "invalid email";
                  }
                  return null;
                },
              ),
              SizedBox(height: responsive.dp(2)),
              InputText(
                label: 'PASSWORD',
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                onChanged: (text) {
                  _password = text;
                },
                validator: (text) {
                  if (text == null || text.trim().length < 6) {
                    return "invalid password";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: responsive.dp(5),
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.pinkAccent),
                    ),
                    onPressed: _submit,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'Sign up',
                        style: TextStyle(fontSize: responsive.dp(1.6)),
                      ),
                    )),
              ),
              SizedBox(
                height: responsive.dp(2),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'New to Friendly Desi?',
                    style: TextStyle(fontSize: responsive.dp(1.5)),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(fontSize: responsive.dp(1.5)),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: responsive.dp(10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
