// coverage:ignore-file
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {

  static late SharedPreferences _prefs;

  /// private constructor which prevents the class from being instantiated.
  AppSharedPreferences._();

  /// Initialisation
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Sauvegarder une valeur String
  static Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  /// Récupérer une valeur String
  static String? getString(String key) {
    return _prefs.getString(key);
  }

  /// Sauvegarder une liste de String
  static Future<bool> setListString(String key,  List<String> value) async {
    return await _prefs.setStringList(key, value);
  }

  /// Sauvegarder une valeur int
  static Future<bool> setInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  /// Récupérer une valeur int
  static int? getInt(String key) {
    return _prefs.getInt(key);
  }

  /// Sauvegarder une valeur booléenne
  static Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  /// Récupérer une valeur booléenne
  static bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  /// Supprimer une clé spécifique
  static Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  /// Vider toutes les données stockées
  static Future<bool> clear() async {
    return await _prefs.clear();
  }
}
