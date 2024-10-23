import 'package:flutter/material.dart';
import 'package:housebookingapp/components/custom_drawer.dart';
import 'package:provider/provider.dart';
import '../components/custom_listtlile.dart';
import '../modal/favorites_provider.dart';


class FavoritesPage extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  const FavoritesPage({
    super.key,
    required this.onThemeChanged,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {

    final favoriteItems = context.watch<FavoritesProvider>().favoriteItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
        centerTitle: true,
      ),
      drawer: CustomDrawer(
        isDarkMode: isDarkMode,
        onThemeChanged: onThemeChanged,
      ),
      body: ListView.builder(
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          var item = favoriteItems[index];
          bool isFavorite = true;

          return RentListTile(
            title: item['title'],
            isFavorite: isFavorite,
            onFavoriteChanged: (isFavorite) {

            },
            imageUrl: item['imageUrl'],
            houseName: item['houseName'],
          );
        },
      ),
    );
  }
}
