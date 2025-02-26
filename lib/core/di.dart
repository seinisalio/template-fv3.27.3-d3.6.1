
import '../modules/config/domain/services/config_service.dart';
import '../modules/config/ports/input/config_input_port.dart';

class Di {
  
  /// Configuration - paramètres - préférences utilisateur
  static ConfigInputPort? configInputPort;

  /// Retourne l'implementation Input Port
  static ConfigInputPort getConfigInputPort() {
    return configInputPort??ConfigService();
  }
}