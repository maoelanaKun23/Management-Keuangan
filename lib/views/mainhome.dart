import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../views/homeviews.dart';

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

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
        // indicatorColor: const Color(0xFF2499C0),
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
            label: 'Artickel',
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
          margin: const EdgeInsets.all(8.0),
          child: SizedBox.expand(
            child: Center(
              child: Text(
                'Home page',
                style: theme.textTheme.titleLarge,
              ),
            ),
          ),
        ),
        // Halaman Notifications
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 1'),
                  subtitle: Text('This is a notification'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 2'),
                  subtitle: Text('This is a notification'),
                ),
              ),
            ],
          ),
        ),
        // Halaman Messages
        ListView.builder(
          reverse: true,
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Hello',
                    style: theme.textTheme.bodyLarge!
                        .copyWith(color: theme.colorScheme.onPrimary),
                  ),
                ),
              );
            }
            return Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Hi!',
                  style: theme.textTheme.bodyLarge!
                      .copyWith(color: theme.colorScheme.onPrimary),
                ),
              ),
            );
          },
        ),
        Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(0.0),
          child: SizedBox.expand(
            child: Center(child: Homeviews()),
          ),
        ),
      ][currentPageIndex],
    );
  }
}
