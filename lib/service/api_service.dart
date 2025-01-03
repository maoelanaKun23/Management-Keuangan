import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/User.dart'; // Pastikan model LoginResponse diimpor

class ApiService {
  final String _baseUrl = 'http://10.200.200.158:8080'; // Ganti dengan base URL Anda

  // Fungsi login yang menerima email dan password
  Future<LoginResponse> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Jika login berhasil, parsing JSON ke LoginResponse
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }
}
