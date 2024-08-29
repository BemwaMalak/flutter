import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:elswedy/login_screen.dart';

void main() async {
  testWidgets('Displays error message on login failure', (WidgetTester tester) async {
    // Mock the environment variable to simulate a failed login

    // Build the LoginScreen with the real authentication service
    await tester.pumpWidget(
      MaterialApp(
        home: LoginScreen(),
      ),
    );

    // Enter email and password
    await tester.enterText(find.byType(TextFormField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');

    // Tap the login button
    await tester.tap(find.text('Login'));

    // Wait for the asynchronous call to complete
    await tester.pump();

    expect(find.text('An error occurred'), findsOneWidget);
  });
}
