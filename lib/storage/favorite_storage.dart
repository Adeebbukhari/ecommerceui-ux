import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../globals.dart';
import '../api/api_service.dart';

class FavoriteStorage {
  static const String _favKey = "favoriteItems";

  static Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(_favKey);
    if (jsonString != null) {
      return List<String>.from(jsonDecode(jsonString));
    }
    return [];
  }

  static Future<void> saveFavorites(List<String> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_favKey, jsonEncode(favorites));
    favoriteNotifier.value = favorites;
  }

  static Future<void> toggleFavorite(String productId) async {
    List<String> current = await getFavorites();
    if (current.contains(productId)) {
      current.remove(productId);
    } else {
      current.add(productId);
    }
    await saveFavorites(current);
  }

  static Future<void> removeFavorite(String productId) async {
    List<String> current = await getFavorites();
    if (current.contains(productId)) {
      current.remove(productId);
      await saveFavorites(current);
    }
  }

  // 🔹 Helper to get product data by id
  static Future<Map<String, dynamic>?> getProductById(String id) async {
    final products = await fetchProducts();
    try {
      return products.firstWhere((p) => p['id'].toString() == id);
    } catch (e) {
      return null;
    }
  }
}
