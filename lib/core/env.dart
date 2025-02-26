// coverage:ignore-file
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Permet d'utiliser les variables d'environnement de l'application
class AppEnv {

  /// private constructor which prevents the class from being instantiated.
  AppEnv._();

  static Future<void> init() async{
    // Charger les variables d'environnement
    await dotenv.load(fileName: '.env');
  }

  /// Récupère la valeur d'une variable d'environnement
  static String? get(String name) => dotenv.env[name];
}
