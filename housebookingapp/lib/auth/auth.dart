import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:housebookingapp/auth/login_or_register.dart';
import 'package:housebookingapp/pages/home_page.dart';

class AuthPage extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  const AuthPage({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData && snapshot.data != null) {
          return HomePage(
            isDarkMode: isDarkMode,
            onThemeChanged: onThemeChanged,
          );
        } else {
          return const LoginOrRegister();
        }
      },
    );
  }
}
