// coverage:ignore-file
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppSecureStorage {

  // Create storage
  static late FlutterSecureStorage _storage ;
  /// private constructor which prevents the class from being instantiated.
  AppSecureStorage._();

  /// Initialisation
  static Future<void> init() async {
    _storage = FlutterSecureStorage(
      iOptions: IOSOptions.defaultOptions,
      aOptions: AndroidOptions.defaultOptions,
      webOptions: WebOptions.defaultOptions
    );
  }

  // Récupérer une valeur
  static Future<String?> get(String key) async{
    return await _storage.read(key: key);
  }
  // Enregistrer une valeur
  static Future<void> set(String key, String? value) async{
    await _storage.write(key: key, value: value);
  }
  // Supprimer une valeur
  static Future<void> delete(String key) async{
    await _storage.delete(key: key);
  }
  // Recuperer toutes les valeurs
  static Future<Map<String, String>> getAll() async{
    return await _storage.readAll();
  }
  // Supprimer toutes les valeurs
  static Future<void> deleteAll() async{
    await _storage.deleteAll();
  }
  //
  static Future<bool> isKeyExist(String key) async{
    return await _storage.containsKey(key: key);
  }
}
