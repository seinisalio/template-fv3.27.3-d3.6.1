import '../../domain/models/config_params.dart';

///
/// Porte d'entrée pour pouvoir gerer la configuration de l'app
///
abstract class ConfigInputPort {
  String? get(String key);
  ///
  /// Récupère les configurations de l'application
  ///
  ConfigParams getAll();
  ///
  /// Mets à jour la configuration de [key] avec la valeur [value]
  ///
  Future<void> update(String key, String value);
}
