import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../routes/app_routes.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  String _message = '';

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse('https://6718f6bc7fc4c5ff8f4be207.mockapi.io/api/v1/users'),
      );

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        final List<dynamic> users = json.decode(response.body);

        final user = users.firstWhere(
          (user) =>
              user['email'] == _usernameController.text &&
              user['password'] == _passwordController.text,
          orElse: () => null,
        );

        if (user != null) {
          Navigator.of(context).pushNamed(
            AppRoutes.mainhome,
            arguments: user,
          );
        } else {
          _message = 'Invalid email or password.';
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(_message)));
        }
      } else {
        _message = 'Error fetching users. Please try again later.';
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(_message)));
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      _message = 'Error logging in, please try again later.';
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(_message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF2499C0),
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              height: 400,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/CuanM.png',
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username or Email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 30),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 30),
                      _isLoading
                          ? CircularProgressIndicator()
                          : Container(
                              width: 200,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: const Color(0xFF2499C0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 30),
                                ),
                                onPressed: _login,
                                child: const Text('Login'),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
