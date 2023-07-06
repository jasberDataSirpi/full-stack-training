import 'package:flutter/material.dart';
import 'package:meal_planet/services/local_storage_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPage();
}

class _DashboardPage extends State<DashboardPage> {
  onClickLogout() async {
    await saveInSecureStorage("access_token", "");
    Navigator.pushNamed(context, "/login");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24.0),
        const Text("Dashboard Page"),
        const SizedBox(height: 24.0),
        Container(
          height: 50,
          width: 250,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
          child: ElevatedButton(
            onPressed: onClickLogout,
            child: const Text('Logout'),
          ),
        ),
      ],
    );
  }
}
