import 'package:flutter/material.dart';
import 'package:meal_planet/pages/dashboard_page.dart';
import 'package:meal_planet/pages/login_page.dart';
import 'package:meal_planet/services/auth_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isAuthorized = false;

  Future<bool> setIsAuthorized() async {
    var isAuthorized = await isAuthorised();
    return isAuthorized;
  }

  getInitialPage() {
    return isAuthorized ? const DashboardPage() : const LoginPage();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: setIsAuthorized(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return getInitialPage();
          } else {
            return const Text("Loading");
          }
        });
  }
}
