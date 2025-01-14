import 'package:flutter/material.dart';
import '../routes/app_routes.dart';
import '../component/modallogout.dart';

class HomeViews extends StatefulWidget {
  final Map<String, dynamic> userData;

  const HomeViews({super.key, required this.userData});

  @override
  _HomeViewsState createState() => _HomeViewsState();
}

class _HomeViewsState extends State<HomeViews> {
  late String name;
  late String jenis_kelamin;
  late String nomor_telepon;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    name = widget.userData['name'];
    jenis_kelamin = widget.userData['jenis_kelamin'];
    nomor_telepon = widget.userData['nomor_telepon'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 16.0, top: 20.0),
                  child: const Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 700,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipOval(
                          child: Image.asset(
                            'assets/images/foto.png',
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          width: 200,
                          margin: const EdgeInsets.only(top: 60.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Username :',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                name,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                              const SizedBox(height: 22),
                              Row(
                                children: [
                                  Icon(
                                    Icons.male,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Gender :',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                jenis_kelamin,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                              const SizedBox(height: 22),
                              Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Phone :',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                nomor_telepon,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                              const SizedBox(height: 22),
                              Container(
                                width: 200,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(
                                        color: Color(0xFF2499C0),
                                        width: 2,
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: 30,
                                    ),
                                  ),
                                  onPressed: () {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text('Confirm Logout'),
                                        content: const Text(
                                            'Are you sure you want to logout?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.pushNamed(
                                                  context, AppRoutes.login);
                                            },
                                            child: const Text('Logout'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Logout',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2499C0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
