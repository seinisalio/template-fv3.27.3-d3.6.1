import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../../../../core/assets.dart';
import '../../../../../core/theme.dart';
import '../../../core/router/router.dart';
import '../../../shared/widgets/custom_checked_dot.dart';
import '../../config/domain/models/config_keys.dart';
import '../../config/ui/bloc/config_bloc.dart';
import '../../config/ui/bloc/config_event.dart';
import '../../config/ui/bloc/config_state.dart';


class SettingPageThemeSheet extends StatelessWidget {

  const SettingPageThemeSheet({super.key,});

  @override
  Widget build(BuildContext context) {
    AppLocalizations traductions = AppLocalizations.of(context)!;

    ConfigBloc configBloc = context.read<ConfigBloc>();
    
    return BlocBuilder<ConfigBloc, ConfigState>(
      bloc: configBloc,
      buildWhen: (previousState, currentState) {
        return currentState is ConfigLoadedState && 
          ConfigKey.preferedTheme == currentState.updatedKey;
      },
      builder:(context, state) {
        String? currentTheme = state.configParams.params[ConfigKey.preferedTheme.code];
    
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
                      traductions.settingPageMenuThemeTitle,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    // Séparateur
                    const SizedBox(height: 8.0),
    
                    // Sous titre de la page
                    Text(
                      traductions.selectedThemePageSubTitle,
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
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Wrap(
                            // Space between items horizontally
                            spacing: 10.0, 
                            // Space between rows
                            runSpacing: 10.0, 
                            // Main axis alignment
                            alignment: WrapAlignment.spaceBetween,
                            children: Themes.list().map<Widget>((theme)  
                              => _widget(context,traductions,
                                bloc: configBloc,
                                theme: theme,
                                currentTheme: currentTheme
                              ),
                            ).toList(),
                          ),
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
    AppLocalizations traductions,
    {
      required ConfigBloc bloc, 
      required Themes theme,
      String? currentTheme,
    }){

    return InkWell(
      onTap: currentTheme != theme.code ? (){
        bloc.add(ConfigChangeEvent(ConfigKey.preferedTheme, theme.code));
        AppRouter.pop(context);
      }: null,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              image: DecorationImage(
                image: AssetImage(_themeIcon(theme)),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            _themeTitle(traductions,theme),
            style: Theme.of(context).
              textTheme.displayMedium,
          ),
          const SizedBox(height: 5),
          CustomDot(value: currentTheme == theme.code),
        ],
      ),
    );
  }

  String _themeIcon(Themes theme){
    if(theme == Themes.light){
      return AppImages.themeLight;
    }
    else if(theme == Themes.dark){
      return AppImages.themeDark;
    }
    return AppImages.themeSystem;
  }

  String _themeTitle(AppLocalizations traductions, Themes theme){
    if(theme == Themes.light){
      return traductions.settingPageMenuThemeLight;
    }
    else if(theme == Themes.dark){
      return traductions.settingPageMenuThemeDark;
    }
    return traductions.settingDefault;
  }
}