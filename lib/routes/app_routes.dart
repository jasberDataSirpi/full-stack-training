import '../details_screen.dart';
import '../home_screen.dart';

class AppRoutes {
  final Map<String, dynamic> _routes = {
    '/': (context) => const HomeScreen(),
    '/details': (context) => const DetailsScreen(),
  };

  getRoutes() {
    return _routes;
  }
}
