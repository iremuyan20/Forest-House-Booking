import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:housebookingapp/auth/login_or_register.dart';
import 'package:housebookingapp/pages/for_rent_page.dart';
import 'package:housebookingapp/pages/login_page.dart';
import '../auth/auth.dart';
import '../pages/favorites_page.dart';
import '../pages/home_page.dart';

class CustomDrawer extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;
  const CustomDrawer({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

  void signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {

    }
  }
  @override
  Widget build(BuildContext context) {

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          Container(
            child: DrawerHeader(
              child: Column(
                children: [
                  Icon(
                    FontAwesomeIcons.tree,
                    color: Theme.of(context).colorScheme.inversePrimary,
                    size: 40,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: ListTile(
              leading: Icon(
                Icons.home,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: const Text("H O M E"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(
                      isDarkMode: widget.isDarkMode,
                      onThemeChanged: (isDarkMode) {
                        setState(() {
                          widget.onThemeChanged(isDarkMode);
                        });
                      },
                    ),
                  ),
                );
              },

            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: ListTile(
              leading: Icon(
                Icons.home_work_rounded,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: const Text("F O R  R E N T"),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ForRentPage(
                      isDarkMode: widget.isDarkMode,
                      onThemeChanged: (isDarkMode) {
                        setState(() {
                          widget.onThemeChanged(isDarkMode);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: ListTile(
              leading: Icon(
                Icons.favorite,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: const Text("F A V O R I T E S"),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoritesPage(
                      isDarkMode: widget.isDarkMode,
                      onThemeChanged: (isDarkMode) {
                        setState(() {
                          widget.onThemeChanged(isDarkMode);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
