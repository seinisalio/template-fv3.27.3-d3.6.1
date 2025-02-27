import 'dart:ui';

enum Languages {
  //
  fr("fr_Fr"),
  en("en_En");

  // Codification du theme
  final String code;

  const Languages(this.code);

  static List<Languages> list() => Languages.values;

  static Iterable<Locale> supportedLanguages() => 
    Languages.values.map<Locale>((e) => Locale(e.name));
}

class AppLanguage {
   static Locale get(String? code) {
    //
    if (code == Languages.fr.code) {
      return Locale(Languages.fr.name);
    }
    //
    else if (code == Languages.en.code) {
      return Locale(Languages.en.name);
    }
    //
    else {
      Locale locale = PlatformDispatcher.instance.locale;
      if(['fr','en'].contains(locale.languageCode)){
        return locale;
      }
      return Locale(Languages.fr.name);
    }
  }
}