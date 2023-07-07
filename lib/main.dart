import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meal_planet/pages/dashboard_page.dart';
import 'package:meal_planet/pages/login_page.dart';
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
      "/": (context) => const MyHomePage(title: 'Meal Planet'),
      '/login': (context) => const LoginPage(),
      '/register': (context) => const RegisterPage(),
      '/dashboard': (context) => const DashboardPage()
    };
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meal Planet',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme, // Use the default TextTheme
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: routes,
    );
  }
}
