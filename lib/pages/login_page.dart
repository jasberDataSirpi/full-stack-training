import 'dart:convert';
import 'dart:io';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                  hintText: 'Enter User Name',
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter Password',
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 24.0),
            Container(
                height: 50,
                width: 250,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(4)),
                child: ElevatedButton(
                  onPressed: _login,
                  child: const Text('Login'),
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
