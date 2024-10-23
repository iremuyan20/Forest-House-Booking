import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:housebookingapp/auth/auth.dart';
import 'package:housebookingapp/firebase_options.dart';
import 'package:housebookingapp/theme/dark_mode.dart';
import 'package:housebookingapp/theme/light_mode.dart';
import 'package:provider/provider.dart';

import 'modal/favorites_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoritesProvider(),
      child: MaterialApp(
        title: 'House Booking App',
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        darkTheme: darkMode,
        themeMode: ThemeMode.dark,
        home: AuthPage(
          isDarkMode: true,
          onThemeChanged: (bool isDarkMode) {},
        ),
      ),
    );
  }
}
