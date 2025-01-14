
import 'package:flutter/material.dart';
import 'package:flutter_api_rest/utils/responsive.dart';
import 'package:flutter_api_rest/widgets/circle.dart';
import 'package:flutter_api_rest/widgets/icon_container.dart';
import 'package:flutter_api_rest/widgets/login_form.dart';

class LoginPage extends StatefulWidget {

  static const String routeName = 'login';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final double pinkSize = responsive.wp(80);
    final double orangeSize = responsive.wp(57);

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: responsive.height,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  right: -pinkSize * 0.2,
                  top: -pinkSize * 0.4,
                  child: Circle(
                    size: pinkSize,
                    colors: const [
                      Colors.pink,
                      Colors.pinkAccent
                    ],
                  ),
                ),
                Positioned(
                  left: -orangeSize * 0.15,
                  top: -orangeSize * 0.55,
                  child: Circle(
                    size: orangeSize,
                    colors: const [
                      Colors.orange,
                      Colors.deepOrangeAccent
                    ],
                  ),
                ),
                Positioned(
                  top: pinkSize * 0.4,
                  child: Column(
                    children: [
                      IconContainer(
                        size: responsive.wp(17),
                      ),
                      SizedBox(
                        height: responsive.dp(3),
                      ),
                      Text(
                        "Hello Again\nWelcome Back",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: responsive.dp(1.7)
                        ),
                      ),
                    ],
                  ),
                ),
                const LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
