import 'package:flutter/material.dart';
import 'package:flutter_api_rest/widgets/input_text.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      left: 20,
      right: 20,
      child: Column(
        children: [
          const InputText(
            label: 'EMAIL ADDRESS',
            keyboardType: TextInputType.emailAddress,
            obscureText: false,
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                    color: Colors.black12
                  )
              ), 
            ),
            child: Row(
              children: [
                const Expanded(
                  child:  InputText(
                    label: 'PASSWORD',
                    obscureText: true,
                    borderEnable: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot Password",
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                  ),
                )
             ],
           ),
         ),
        ],
      ),
    );
  }
}
