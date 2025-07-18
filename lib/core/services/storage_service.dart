import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class StorageService {
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';
  static const String _languageKey = 'app_language';

  final SharedPreferences _prefs;

  StorageService(this._prefs);

  // Auth Storage
  Future<void> saveAuthData(String token, User user) async {
    await _prefs.setString(_tokenKey, token);
    await _prefs.setString(_userKey, jsonEncode(user.toJson()));
  }

  Future<String?> getToken() async {
    return _prefs.getString(_tokenKey);
  }

  Future<User?> getUser() async {
    final userJson = _prefs.getString(_userKey);
    if (userJson != null) {
      return User.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  Future<void> clearAuthData() async {
    await _prefs.remove(_tokenKey);
    await _prefs.remove(_userKey);
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    final user = await getUser();
    return token != null && user != null;
  }

  // Language Storage
  Future<void> saveLanguage(String languageCode) async {
    await _prefs.setString(_languageKey, languageCode);
  }

  Future<String> getLanguage() async {
    return _prefs.getString(_languageKey) ?? 'en';
  }

  // Settings Storage
  Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  Future<bool> getBool(String key, {bool defaultValue = false}) async {
    return _prefs.getBool(key) ?? defaultValue;
  }

  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    return _prefs.getString(key);
  }
}