import '../../domain/models/config_keys.dart';

abstract class ConfigEvent {
  const ConfigEvent();
}

/// Au chargement de la configuration / chargement de l'application
///
class ConfigAskedEvent extends ConfigEvent {
  //
  const ConfigAskedEvent();
}

/// Pour demander le changement de configuration
/// d'un parametre
class ConfigChangeEvent extends ConfigEvent {
  //
  const ConfigChangeEvent(this.configKey, this.configValue);

  // Clé du Parametre de configuration à changer
  final ConfigKey configKey;
  // Valeur du Parametre de configuration à changer
  final String configValue;
}

/// Recuperer la liste des configs de la configuration
///
class ConfigLoadedEvent extends ConfigEvent {
  //
  const ConfigLoadedEvent();
}
