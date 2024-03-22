import 'package:flutter/material.dart';
import 'package:flutter_api_rest/api/authentication_api.dart';
import 'package:flutter_api_rest/models/user_credential_model.dart';
import 'package:flutter_api_rest/data/authentication_client.dart';
import 'package:flutter_api_rest/pages/home_page.dart';
import 'package:flutter_api_rest/pages/register_page.dart';
import 'package:flutter_api_rest/utils/dialogs.dart';
import 'package:flutter_api_rest/utils/responsive.dart';
import 'package:flutter_api_rest/widgets/input_text.dart';
import 'package:get_it/get_it.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _authenticationApi = GetIt.instance<AuthenticationApi>();
  final _authenticationClient = GetIt.instance<AuthenticationClient>();
  String email = '';
  String password = '';

  Future<void> _submit() async {
    final bool isOk = _formKey.currentState!.validate();
    if (isOk) {
      ProgressDialog.show(context);

      final response = await _authenticationApi.login(
          userCredential:
              UserCredentialModel(email: email, password: password));
      ProgressDialog.dismiss(context);

      if (response.data != null) {
        await _authenticationClient.saveSession(response.data!);
        Navigator.pushNamedAndRemoveUntil(
          context,
          HomePage.routeName,
          (_) => false,
        );
      } else {
        String message = response.error!.message;

        if (response.error!.statusCode == -1) {
          message = 'Bad Network';
        } else if (response.error!.statusCode == 403) {
          message = 'Invalid password';
        } else if (response.error!.statusCode == 404) {
          message = 'User not found';
        }

        Dialogs.alert(context, title: 'Error', description: message);
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
                label: 'EMAIL ADDRESS',
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                onChanged: (text) {
                  email = text;
                },
                validator: (text) {
                  if (text == null || !text.contains("@")) {
                    return "invalid email";
                  }
                  return null;
                },
              ),
              SizedBox(height: responsive.dp(2)),
              Container(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black12)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InputText(
                        label: 'PASSWORD',
                        obscureText: true,
                        borderEnable: false,
                        fontSize:
                            responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                        onChanged: (text) {
                          password = text;
                        },
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return "Invalid password";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forgot Password",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                                responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
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
                        'Sign in',
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
                      Navigator.pushNamed(context, RegisterPage.routeName);
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
