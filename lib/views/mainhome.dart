import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'profile.dart';
import '../views/home_page.dart';
import '../views/statistic.dart';
import '../views/artikel.dart';

class NavigationExample extends StatefulWidget {
  final Map<String, dynamic> userData;

  const NavigationExample({super.key, required this.userData});

  @override
  _NavigationExampleState createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.transparent,
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: SvgPicture.asset(
              'assets/icons/homeactive.svg',
              width: 30,
              height: 30,
            ),
            icon: SvgPicture.asset(
              'assets/icons/homenonactive.svg',
              width: 30,
              height: 30,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: SvgPicture.asset(
              'assets/icons/statisticactive.svg',
              width: 30,
              height: 30,
            ),
            icon: SvgPicture.asset(
              'assets/icons/statisticnonactive.svg',
              width: 30,
              height: 30,
            ),
            label: 'Statistics',
          ),
          NavigationDestination(
            selectedIcon: SvgPicture.asset(
              'assets/icons/artikelactive.svg',
              width: 30,
              height: 30,
            ),
            icon: SvgPicture.asset(
              'assets/icons/artikelnonactive.svg',
              width: 30,
              height: 30,
            ),
            label: 'Artikel',
          ),
          NavigationDestination(
            selectedIcon: SvgPicture.asset(
              'assets/icons/profileactive.svg',
              width: 30,
              height: 30,
            ),
            icon: SvgPicture.asset(
              'assets/icons/profilenonactive.svg',
              width: 30,
              height: 30,
            ),
            label: 'Profile',
          ),
        ],
      ),
      body: <Widget>[
        // Halaman Home
        Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(0.0),
          child: HomePage(userData: widget.userData),
        ),
        Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(0.0),
          child: TransactionPage(),
        ),
        Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(0.0),
          child: ArtikelPage(),
        ),
        Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(0.0),
          child: Homeviews(),
        ),
      ][currentPageIndex],
    );
  }
}
