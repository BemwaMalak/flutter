import 'package:flutter/material.dart';
import 'package:elswedy/authentication_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final IAuthenticationService authenticationService = AuthenticationService.getInstance()!;
  String errorMessage = '';

  Future<void> _login() async {
    try {
      String email = emailController.text;
      String password = passwordController.text;
      await authenticationService.login(email, password);
      // If successful, you can navigate to another screen or show a success message
    } catch (e) {
      setState(() {
        errorMessage = 'An error occurred';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                const Text("Email: "),
                SizedBox(
                  width: 150,
                  child: TextFormField(
                    controller: emailController,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text("Password: "),
                SizedBox(
                  width: 150,
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                  ),
                ),
              ],
            ),
            MaterialButton(
              child: const Text("Login"),
              onPressed: _login,
            ),
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
