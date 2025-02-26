

import '../../../../core/local_storage/shared_preferences.dart';
import '../../ports/input/config_input_port.dart';
import '../models/config_keys.dart';
import '../models/config_params.dart';

/// Service contenant la logique de gestion des configurations
class ConfigService implements ConfigInputPort {
 
  const ConfigService();

  @override
  String? get(String key) {
    return AppSharedPreferences.getString(key);
  }

  @override
  ConfigParams getAll() {
    Map<String, String?> params = {
      for (var paramkey in ConfigKey.list()) paramkey: AppSharedPreferences.getString(paramkey)
    };
    return ConfigParams(params);
  }

  @override
  Future<void> update(String key, String value) async {
    await AppSharedPreferences.setString(key, value);
  }
}
