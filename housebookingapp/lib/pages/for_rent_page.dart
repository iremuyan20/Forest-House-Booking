import 'package:flutter/material.dart';
import '../components/custom_drawer.dart';
import 'package:provider/provider.dart';
import '../components/custom_listtlile.dart';
import '../modal/favorites_provider.dart';

class ForRentPage extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  const ForRentPage({
    super.key,
    required this.onThemeChanged,
    required this.isDarkMode,
  });

  @override
  _ForRentPageState createState() => _ForRentPageState();
}

class _ForRentPageState extends State<ForRentPage> {

  List<Map<String, dynamic>> rentItems = [
    {'title': 'Karnataka, India', 'imageUrl': 'img/listtileimg1.jpg', 'houseName': 'Aplusd Homes'},
    {'title': 'Palawan, Philippines', 'imageUrl': 'img/listtileimg2.jpg', 'houseName': 'The Ruka Villa'},
    {'title': 'Pomerode, Brazil', 'imageUrl': 'img/listtileimg3.jpg', 'houseName': 'The Corten Residence'},
    {'title': 'Curitiba, Brazil', 'imageUrl': 'img/listtileimg4.jpg', 'houseName': 'Pousada Hoff Haus'},
    {'title': 'Pigeon Forge, ABD', 'imageUrl': 'img/listtileimg5.jpg', 'houseName': 'Econo Lodge Pigeon Forge'},
    {'title': 'Dalat, Vietnam', 'imageUrl': 'img/listtileimg6.jpg', 'houseName': 'Charming Woodland '},
    {'title': 'Puerto Iguazú, Argentina', 'imageUrl': 'img/listtileimg7.jpg', 'houseName': 'Selvaje Lodge Iguazu'},
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {

    List<Map<String, dynamic>> filteredItems = rentItems.where((item) {
      return item['title'].toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text("For Rent"),
        centerTitle: true,
      ),
      drawer: CustomDrawer(
        isDarkMode: widget.isDarkMode,
        onThemeChanged: widget.onThemeChanged,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                var item = filteredItems[index];
                bool isFavorite = context.watch<FavoritesProvider>().isFavorite(item);

                return Column(
                  children: [
                    RentListTile(
                      title: item['title'],
                      isFavorite: isFavorite,
                      onFavoriteChanged: (isFavorite) {
                        if (isFavorite) {
                          context.read<FavoritesProvider>().addFavorite(item);
                        } else {
                          context.read<FavoritesProvider>().removeFavorite(item);
                        }
                      },
                      imageUrl: item['imageUrl'],
                      houseName: item['houseName'],
                    ),
                    const SizedBox(height: 10),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
