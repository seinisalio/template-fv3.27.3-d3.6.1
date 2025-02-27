import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:template/modules/settings/ui/settings_page_language.dart';

import '../../../../../core/assets.dart';
import '../../../../../core/language.dart';
import '../../../../../core/theme.dart';
import '../../../shared/widgets/custom_icon_widget.dart';
import '../../../shared/widgets/page_container.dart';
import '../../config/domain/models/config_keys.dart';
import '../../config/ui/bloc/config_bloc.dart';
import '../../config/ui/bloc/config_state.dart';
import 'settings_page_theme.dart';

class SettingsPage extends StatelessWidget {
  //
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    //
    AppLocalizations traductions = AppLocalizations.of(context)!;

    ConfigBloc configBloc = context.read<ConfigBloc>();

    return Scaffold(
      // Pour avoir le bouton de retour
      appBar: AppBar(),

      // Body
      body: BlocBuilder<ConfigBloc, ConfigState>(
        bloc: configBloc,
        buildWhen: (previousState, currentState) {
          return currentState is ConfigLoadedState &&
          [ ConfigKey.preferedLanguage,
            ConfigKey.preferedTheme,
          ].contains(currentState.updatedKey); 
        },
        builder: (context, state) {
          // Paramètre langage
          String? language = state.configParams.params[ConfigKey.preferedLanguage.code];
          // Paramètres thème
          String? theme = state.configParams.params[ConfigKey.preferedTheme.code];

          return PageContainer(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Page title
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(
                      traductions.settingPageTitle,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),

                  // Spacer
                  const SizedBox(height: 24),

                  Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Langue
                        _menu(
                          context, 
                          icon: AppIcons.language,
                          title: traductions.settingPageMenuLanguageTitle, 
                          subtitle: _selectedLanguage(traductions,language),
                          onTap: () => showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return const SettingPageLanguageSheet();
                            },
                            isScrollControlled: true,
                          ),
                        ),
                        // Thème
                        _menu(
                          context, 
                          icon: AppIcons.theme,
                          title: traductions.settingPageMenuThemeTitle, 
                          subtitle: _selectedTheme(traductions,theme),
                          onTap: () => showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return const SettingPageThemeSheet();
                            },
                            isScrollControlled: true,
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ListTile _menu(
    BuildContext context,
    {
      required String title,
      String? subtitle,
      required String icon,
      Function()? onTap,
    }){
    return ListTile(
      onTap: onTap,
      leading: CustomIcon(icon: icon,),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      subtitle: subtitle != null
      ? Text(
          subtitle,
          style: Theme.of(context).textTheme.displaySmall,
        )
      : null,
    );
  }

  String _selectedLanguage(AppLocalizations traductions,String? langage){
    if(langage == Languages.fr.code){
      return traductions.settingPageMenuLanguageFr;
    }else if(langage == Languages.en.code){
      return traductions.settingPageMenuLanguageEn;
    }
    return traductions.settingDefault;
  }

  String _selectedTheme(AppLocalizations traductions,String? theme){
    if(theme == Themes.light.code){
      return traductions.settingPageMenuThemeLight;
    }else if(theme == Themes.dark.code){
      return traductions.settingPageMenuThemeDark;
    }
    return traductions.settingDefault;
  }
}
