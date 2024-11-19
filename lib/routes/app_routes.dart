import 'package:flutter/material.dart';
import '../views/home.dart';
import '../views/login.dart';
import '../views/mainhome.dart';
import '../views/home_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String mainhome = '/mainhome';
  static const String homepage = '/homepage';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget page;
    switch (settings.name) {
      case home:
        page = Home();
        break;
      case login:
        page = Login();
        break;
      case mainhome:
        page = const NavigationExample();
        break;
      case homepage:
        page = HomePage();
        break;
      default:
        page = Home(); // Halaman default
    }
    return _createRouteWithLoading(page);
  }

  // Fungsi untuk membuat route dengan animasi dan loading
  static PageRouteBuilder _createRouteWithLoading(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      transitionDuration: Duration(milliseconds: 1000),
      fullscreenDialog: true, // Untuk menunjukkan halaman sebagai dialog penuh
    );
  }
}

// Fungsi untuk menunjukkan dialog loading
void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}
