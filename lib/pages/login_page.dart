import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meal_planet/constants/endpoints.dart';
import 'package:meal_planet/constants/http_methods.dart';
import 'package:meal_planet/services/http_service.dart';
import 'package:meal_planet/services/local_storage_service.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 30),
            Text(
              'Login',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1,
                ),
              ),
            ),
            const SizedBox(height: 120),
            SizedBox(
              width: 370,
              // height: 56,
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xFFF1F5F5),
                  labelText: 'User Name',
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 370,
              // height: 56,
              child: TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xFFF1F5F5),
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 40),
            Container(
                width: 370,
                height: 56,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF01CBBB)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                  onPressed: _login,
                  child: const Text(
                    'Log In',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/register");
              },
              child: const Text(
                'Create New Account',
                style: TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              message,
              style: TextStyle(color: Colors.green.shade400),
            ),
          ],
        ),
      ),
    );
  }
}
