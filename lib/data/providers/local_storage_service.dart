import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String KEY_IS_LOGGED_IN = 'isLoggedIn';
  static const String KEY_USER_ID = 'userId';

  static Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(KEY_IS_LOGGED_IN, value);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(KEY_IS_LOGGED_IN) ?? false;
  }

  static Future<void> setUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(KEY_USER_ID, userId);
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(KEY_USER_ID);
  }
}