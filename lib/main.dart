import 'package:flutter/material.dart';
import './routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

AppRoutes appRoutes = AppRoutes();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      initialRoute: '/',
      routes: appRoutes.getRoutes(),
    );
  }
}
