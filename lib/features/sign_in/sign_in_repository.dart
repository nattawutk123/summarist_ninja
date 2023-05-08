import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/config.dart' as config;

class SignInRepository {
  Future<String?> signIn(String email, String password) async {
    const url = 'http://${config.ip}:${config.port}${config.apiLogin}';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final token = responseData['token'];
        return token.isNotEmpty ? token : null;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> saveToken(String token) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', token);
      return true;
    } catch (e) {
      return false;
    }
  }
}
