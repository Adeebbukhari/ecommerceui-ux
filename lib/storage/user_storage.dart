import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences package

class UserStorage {
  // Save user data to local storage
  static Future<void> saveUserData({
    required String name,
    required String email,
    required String mobile,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance(); // Access local storage
    await prefs.setString('name', name); // Save name
    await prefs.setString('email', email); // Save email
    await prefs.setString('mobile', mobile); // Save mobile
    await prefs.setString('password', password); // Save password
  }

  // Retrieve user data
  static Future<Map<String, String?>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString('name'),
      'email': prefs.getString('email'),
      'mobile': prefs.getString('mobile'),
      'password': prefs.getString('password'),
    };
  }

  // Clear stored user data (for logout)
  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('name');
    await prefs.remove('email');
    await prefs.remove('mobile');
    await prefs.remove('password');
  }
}
