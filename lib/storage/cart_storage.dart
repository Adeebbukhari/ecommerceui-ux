import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CartStorage {
  static const String _cartKey = "cartItems";

  /// Save/update product count
  static Future<void> saveProductCount(String productId, int count) async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(_cartKey);
    Map<String, dynamic> cart = jsonString != null ? jsonDecode(jsonString) : {};

    if (count > 0) {
      cart[productId] = count; // update/add
    } else {
      cart.remove(productId); // remove if 0
    }

    await prefs.setString(_cartKey, jsonEncode(cart));
  }

  /// Get product count
  static Future<int> getProductCount(String productId) async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(_cartKey);
    if (jsonString == null) return 0;

    final Map<String, dynamic> cart = jsonDecode(jsonString);
    return cart[productId] ?? 0;
  }

  /// Get all cart items
  static Future<Map<String, dynamic>> getAllCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(_cartKey);
    return jsonString != null ? jsonDecode(jsonString) : {};
  }

  /// Clear cart
  static Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }
}

