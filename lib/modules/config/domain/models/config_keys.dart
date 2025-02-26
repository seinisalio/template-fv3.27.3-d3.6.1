/// Définit les paramètres de configurations de l'application
enum ConfigKey {
  //
  all("ALL"), // keyword to say all config params

  // l'utilisateur a passé l'introduction
  introductionPassed("INTRODUCTION_PASSED"),

  // theme de l'utilisateur
  preferedTheme("PREFERED_THEME"),
  // Langue préférée
  preferedLanguage("PREFERED_LANGUAGE");

  // Codification du paramètre
  final String code;

  const ConfigKey(this.code);

  static List<String> list() => ConfigKey.values.map((el) => el.code).toList();
}
