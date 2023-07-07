import 'dart:convert';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:meal_planet/constants/endpoints.dart';
import 'package:meal_planet/constants/http_methods.dart';
import 'package:meal_planet/services/http_service.dart';
import 'package:meal_planet/services/local_storage_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String message = "";

  _login() async {
    String userName = emailController.text;
    String password = passwordController.text;
    final Map<String, String> payload = {
      "username": userName,
      "password": password,
    };
    var response =
        await request(HttpMethods.POST, Endpoints.login, payload: payload);
    if (response.statusCode == HttpStatus.ok) {
      var responseMap = jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        message = responseMap["message"];
      });
      await saveInSecureStorage(
          "access_token", responseMap["payload"]["access_token"]);
      Navigator.pushNamed(context, "/dashboard");
    } else {
      print("Error jass");
    }
  }

  goToSignupPage() {
    Navigator.pushNamed(context, "/register");
  }

  late TapGestureRecognizer _tapGestureRecognizer;

  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer()..onTap = goToSignupPage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w700,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 93),
            SizedBox(
              width: double.infinity, // 100% width
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), // Rounded border
                  color: const Color(0xFFF1F5F5),
                ),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'User Name',
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 20.0,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity, // 100% width
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), // Rounded border
                  color: const Color(0xFFF1F5F5),
                ),
                child: TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Password',
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 20.0,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 37),
            Container(
              width: double.infinity, // 100% width
              height: 56,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xFF01CBBB)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: _login,
                child: const Text(
                  'Log In',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 17),
            const Text(
              'Forgot Password?',
              style: TextStyle(
                color: Color(0xFFBDBDBD),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.98,
              ),
            ),
            const SizedBox(height: 23),
            const Text(
              'Or Login with',
              style: TextStyle(
                color: Color(0xFF757575),
                fontSize: 18,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.09,
              ),
            ),
            const SizedBox(height: 17),
            SizedBox(
              width: 200,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 49,
                    width: 49,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/apple.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 49,
                    width: 49,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/google.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 49,
                    width: 49,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/fb.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 35),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'New user?',
                    style: TextStyle(
                      color: Color(0xFFA8A8A8),
                      fontSize: 16.28,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.08,
                    ),
                  ),
                  const TextSpan(
                    text: ' ',
                    style: TextStyle(
                      color: Color(0xFF757575),
                      fontSize: 16.28,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.08,
                    ),
                  ),
                  TextSpan(
                    text: 'Sign Up',
                    style: const TextStyle(
                      color: Color(0xFF01CBBB),
                      fontSize: 16.28,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.08,
                    ),
                    recognizer: _tapGestureRecognizer,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
