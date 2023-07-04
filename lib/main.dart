import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meal_planet/pages/my_home_page.dart';
import 'package:meal_planet/pages/register_page.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var routes = {
      '/register': (context) => const RegisterPage(),
    };
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meal Planet',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Meal Planet'),
      routes: routes,
    );
  }
}
