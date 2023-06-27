import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:full_stack_training/add_brand.dart';
import 'package:full_stack_training/brands.dart';
import 'package:full_stack_training/food.dart';
import 'package:full_stack_training/discover.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal Planet Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'Meal Planet'),
      initialRoute: "/",
      routes: {
        "/": (context) => const MyHomePage(title: "Meal Planet"),
        "/add-brand": (context) => const AddBrand()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentTabIndex = 0;
  Widget defaultTab = const Brands();

  Map<int, Widget> tabs = {
    0: const Brands(),
    1: const Discover(),
    2: const Food(),
  };

  onclickTab(int index) {
    setState(() {
      defaultTab = tabs[index]!;
      currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(
              Icons.food_bank_outlined,
              size: 40,
            ),
            const SizedBox(width: 8.0),
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: defaultTab,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          onclickTab(index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Brands"),
          BottomNavigationBarItem(icon: Icon(Icons.shop), label: "Discover"),
          BottomNavigationBarItem(icon: Icon(Icons.food_bank), label: "Food"),
        ],
        currentIndex: currentTabIndex,
      ),
    );
  }
}
