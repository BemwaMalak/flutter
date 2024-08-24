import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For jsonEncode
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    final String email = emailController.text;
    final String password = passwordController.text;

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, String> body = {
      'Email': email,
      'Password': password,
    };
    String host = dotenv.get('HOST');
    final response = await http.post(
      Uri.parse('$host/api/Auth/login'), // Replace with your endpoint
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      // Successfully logged in
      final responseData = jsonDecode(response.body);
      final token = responseData['token'];
      print('Login successful! Token: $token');
    } else {
      // Failed to log in
      print('Login failed: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Text("Email: "),
                Container(
                  width: 150,
                  child: TextFormField(
                    controller: emailController,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text("Password: "),
                Container(
                  width: 150,
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                  ),
                ),
              ],
            ),
            MaterialButton(
              child: Text("Login"),
              onPressed: () async {
                try{
                  await login();
                }catch (e) {
                  // Handle error
                  print('An error occurred: $e');
                }

              },
            ),
          ],
        ),
      ),
    );
  }
}
