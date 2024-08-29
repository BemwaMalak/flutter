import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';


abstract class IAuthenticationService {
  Future<void> login(String email, String password) {
    throw UnimplementedError();
  }
}


class AuthenticationService implements IAuthenticationService {
  static AuthenticationService? _authenticationService;
  AuthenticationService._();


  static AuthenticationService? getInstance(){
    _authenticationService ??= AuthenticationService._();

    return _authenticationService;
  }
  @override
  Future<void> login(String email, String password) async {

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, String> body = {
      'Email': email,
      'Password': password,
    };

    final response = await http.post(
      Uri.parse('http://localhost:5186/api/Auth/login'), // Replace with your endpoint
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      // Successfully logged in
      final responseData = jsonDecode(response.body);
      final token = responseData['token'];
      print('Login successful! Token: $token');
    } else {
      throw Error();
    }

    throw Error();
  }
}
