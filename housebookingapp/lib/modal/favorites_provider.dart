import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoritesProvider with ChangeNotifier {
  List<Map<String, dynamic>> _favoriteItems = [];

  FavoritesProvider() {
    _loadFavorites();
  }


  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? favoritesStringList = prefs.getStringList('favorites');
    if (favoritesStringList != null) {
      _favoriteItems = favoritesStringList
          .map((item) => jsonDecode(item) as Map<String, dynamic>)
          .toList();
    }
    notifyListeners();
  }


  void addFavorite(Map<String, dynamic> item) {
    _favoriteItems.add(item);
    _saveFavorites();
    notifyListeners();
  }


  void removeFavorite(Map<String, dynamic> item) {
    _favoriteItems.removeWhere((favItem) => favItem['title'] == item['title']);
    _saveFavorites();
    notifyListeners();
  }


  bool isFavorite(Map<String, dynamic> item) {
    return _favoriteItems.any((favItem) => favItem['title'] == item['title']);
  }


  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favoritesStringList = _favoriteItems
        .map((item) => jsonEncode(item))
        .toList();
    prefs.setStringList('favorites', favoritesStringList);
  }

  List<Map<String, dynamic>> get favoriteItems => _favoriteItems;
}
