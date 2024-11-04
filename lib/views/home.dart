import 'package:flutter/material.dart';
import '../routes/app_routes.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF2499C0), // Using a blue color
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Menampilkan SVG (assuming your SVG image is named 'home.svg')
              SvgPicture.asset(
                'assets/images/home.svg',
                height: 400, // Adjust the height as needed
                width: MediaQuery.of(context).size.width,
              ),
              const SizedBox(height: 20), // Spacing between SVG and text

              // Text elements
              const Text(
                'Making your life easier',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              const Text(
                'Manage your income and expense in the easiest way with this app',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),

              // Button with rounded corners
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.login);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xFF2499C0), // Button text color
                  backgroundColor: Colors.white, // Button background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Add rounded corners
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                ),
                child: const Text('Get Started'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
