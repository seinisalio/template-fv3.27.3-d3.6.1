
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/di.dart';
import 'core/language.dart';
import 'core/router/router.dart';
import 'core/theme.dart';
import 'modules/config/domain/models/config_keys.dart';
import 'modules/config/ui/bloc/config_bloc.dart';
import 'modules/config/ui/bloc/config_state.dart';

/// Premier widget Application lancée par le main
class App extends StatelessWidget {
  //
  /// Constructeur de l'app
  const App({super.key});

  ///
  @override
  Widget build(BuildContext context) {
    // Blocs
    ConfigBloc configBloc = ConfigBloc(Di.getConfigInputPort());

    return MultiBlocProvider(
      providers: [
        BlocProvider<ConfigBloc>(
          create: (BuildContext context) => configBloc,
        ),
      ],
      child: BlocBuilder<ConfigBloc,ConfigState>(
        bloc: configBloc,
        buildWhen: (previous, current) => 
          current is ConfigLoadedState &&
          (current.updatedKey == ConfigKey.preferedTheme || 
          current.updatedKey == ConfigKey.preferedLanguage),
        builder: (context, state) => _appLayout(
          configBloc.state as ConfigLoadedState,context
        ),
      ),
    );
  }

  /// Affiche l'application selon le theme de l'utilisateur
  /// Détermine la page initiale de l'application
  /// Affiche la première page à afficher
  MaterialApp _appLayout(ConfigLoadedState configState, BuildContext context) {
    // Récuperer les paramètres de démarrage
    Map<String, String?> params = configState.configParams.params;

    // Déterminer le theme à utiliser
    ThemeData theme = AppTheme.get(params[ConfigKey.preferedTheme.code]);

    // Déterminer la langue à utiliser
    Locale language = AppLanguage.get(params[ConfigKey.preferedLanguage.code]);

    // Afficher la page principale
    // String pageInitiale = params[ConfigKey.introductionPassed.code] == null
    //     ? AppRouter.introduction
    //     : AppRouter.login;
    String pageInitiale = AppRouter.demo;

    // Passer également la configuration pour le routage dans l'Application
    return MaterialApp.router(
      theme: theme,
      locale: language,
      routerConfig: AppRouter.routes(pageInitiale),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        // provides localized strings and other values
        // for the Material Components library.
        GlobalMaterialLocalizations.delegate,
        // defines the default text direction,
        // either left-to-right or right-to-left, for the widgets library.
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        // Custom translation
        AppLocalizations.delegate,
      ],
      supportedLocales: Languages.supportedLanguages(),
      // Recupération du locale de l'utilisateur
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        for (var locale in supportedLocales) {
          if (locale.languageCode == deviceLocale!.languageCode) {
            return deviceLocale;
          }
        }
        return supportedLocales.first;
      },
      // Scollbehavior
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: PointerDeviceKind.values.toSet(),
      ),
    );
  }
}