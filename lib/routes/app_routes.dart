import 'package:flutter/material.dart';
import '../views/home.dart';
import '../views/login.dart';
import '../views/mainhome.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String mainhome = '/mainhome';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => Home());
      case login:
        return MaterialPageRoute(builder: (_) => Login());
      case mainhome:
        return MaterialPageRoute(builder: (_) => const NavigationExample()); 
      default:
        return MaterialPageRoute(builder: (_) => Home()); // Halaman default
    }
  }
}
