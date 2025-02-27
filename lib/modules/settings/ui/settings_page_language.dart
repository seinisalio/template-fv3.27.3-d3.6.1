import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../../../../core/assets.dart';
import '../../../../../core/language.dart';
import '../../../../../core/theme.dart';
import '../../../core/router/router.dart';
import '../../../shared/widgets/avatar_circle_widget.dart';
import '../../config/domain/models/config_keys.dart';
import '../../config/ui/bloc/config_bloc.dart';
import '../../config/ui/bloc/config_event.dart';
import '../../config/ui/bloc/config_state.dart';


class SettingPageLanguageSheet extends StatelessWidget {

  const SettingPageLanguageSheet({super.key,});

  @override
  Widget build(BuildContext context) {
    AppLocalizations traductions = AppLocalizations.of(context)!;

    ConfigBloc configBloc = context.read<ConfigBloc>();
    
    return BlocBuilder<ConfigBloc, ConfigState>(
      bloc: configBloc,
      buildWhen: (previousState, currentState) {
        return currentState is ConfigLoadedState && 
          currentState.updatedKey == ConfigKey.preferedLanguage;
      },
      builder:(context, state) {
        String? currentLanguage = state.configParams.params[ConfigKey.preferedLanguage.code];
    
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight:  MediaQuery.of(context).size.height * 0.5,
            minWidth: MediaQuery.of(context).size.width
          ),
          child: DecoratedBox(
            decoration: ShapeDecoration(
              color: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Title
                    Text(
                      traductions.settingPageMenuLanguageTitle,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    // Séparateur
                    const SizedBox(height: 8.0),
    
                    // Sous titre de la page
                    Text(
                      traductions.selectedLanguagePageSubTitle,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    //
                    const SizedBox(height: 15,),
                    //
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 10
                        ),
                        child: Column(
                          children: Languages.list().map<Widget>((language) 
                            => _widget(context, 
                              bloc: configBloc,
                              language: language,
                              currentLanguage: currentLanguage
                            ),
                          ).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _widget(
    BuildContext context, 
    {
      required ConfigBloc bloc, 
      required Languages language,
      String? currentLanguage,
    }){

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: currentLanguage == language.code ? BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: AppTheme.neural01Color
      ): null,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: AvatarCircleWidget(
          nom: language.code,
          rounded: true,
          radius: 20,
          photo: _languageLeading(language),
        ),
        title: Text(
          _languageTitle(language),
          style: Theme.of(context).
            textTheme.headlineSmall,
        ),
        subtitle: Text(
          _languageSubTitle(language),
          style: Theme.of(context).
            textTheme.displaySmall,
        ),
        onTap: currentLanguage != language.code ? () {
          bloc.add(ConfigChangeEvent(ConfigKey.preferedLanguage, language.code));
          AppRouter.pop(context);
        }: null,
      ),
    );
  }

  String _languageLeading(Languages language){
    if(language == Languages.en){
      return AppImages.languageEn;
    }
    return AppImages.languageFr;
  }

  String _languageTitle(Languages language){
    if(language == Languages.en){
      return "English";
    }
    return "Français";
  }

  String _languageSubTitle(Languages language){
    if(language == Languages.en){
      return "Used for app language";
    }
    return "Utiliser comme langue par défaut";
  }
}