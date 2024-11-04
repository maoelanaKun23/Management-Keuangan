import 'package:flutter/material.dart';

void main() => runApp(const ModalDialog());

class ModalDialog extends StatelessWidget {
  const ModalDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: const Color(0xff6750a4),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('AlertDialog Sample')),
        body: const Center(
          child: DialogLogout(),
        ),
      ),
    );
  }
}

class DialogLogout extends StatelessWidget {
  const DialogLogout({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Confirm Logout'),
            content: const Text('Are you sure you want to logout?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); 
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        );
      },
      child: const Text('Show Logout Dialog'),
    );
  }
}
