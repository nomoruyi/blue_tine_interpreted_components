import 'package:blue_tine_interpreted_components/app/cubits/settings/settings_cubit.dart';
import 'package:blue_tine_interpreted_components/utils/_utils.export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:settings_ui/settings_ui.dart';


/// NOTE: Not all sub settings have been implemented yet
class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  //region VARIABLES
  late final SettingsCubit _settings = BlocProvider.of<SettingsCubit>(context, listen: true);

  late final Size deviceSize = MediaQuery.of(context).size;

  //endregion

  _removeAllData(BuildContext context) {
    //TODO:
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text('Settings', style: TextStyle(fontSize: UISize.large)),
      ),
      body: SettingsList(
        lightTheme: SettingsThemeData(
          settingsListBackground: Theme.of(context).scaffoldBackgroundColor,
          settingsSectionBackground: Theme.of(context).cardColor,
        ),
        darkTheme: SettingsThemeData(
          settingsListBackground: Theme.of(context).scaffoldBackgroundColor,
          settingsSectionBackground: Theme.of(context).cardColor,
        ),
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 0.0),
        applicationType: Theme.of(context).platform == TargetPlatform.iOS ? ApplicationType.cupertino : ApplicationType.material,
        sections: [
          //region MISC
          SettingsSection(
            title: Text('General',
                style: TextStyle(fontSize: UISize.large, color: Theme.of(context).primaryColor)),
            tiles: [
/*              SettingsTile(
                leading: SizedBox(
                    width: deviceSize.width * 0.35,
                    child: Text('Language', style: TextStyle(fontSize: UISize.medium))),
                title: _buildLanguageSelection(),
              ),*/
              /*SettingsTile(
                leading: SizedBox(
                    width: deviceSize.width * 0.35,
                    child: Text('UI Size', style: TextStyle(fontSize: UISize.medium))),
                title: _buildUISizeSelection(),
              ),*/
              SettingsTile(
                leading: Text('Dark Theme', style: TextStyle(fontSize: UISize.medium)),
                title: _buildThemeToggle(),
              ),
            ],
          ),
          //endregion

          //region INFO
          SettingsSection(
            title: Text('Info',
                style: TextStyle(fontSize: UISize.large, color: Theme.of(context).primaryColor)),
            tiles: [

              SettingsTile.navigation(
                onPressed: (context) => print('Imprint'),
                title: Text('Imprint', style: TextStyle(fontSize: UISize.medium)),
                trailing: Icon(Icons.adaptive.arrow_forward),
              ),
              SettingsTile.navigation(
                onPressed: (context) => showAboutDialog(
                    context: context,
                    applicationIcon: Image.asset(
                      'assets/icons/bio_courier_app_icon.png',
                      fit: BoxFit.contain,
                      width: 100.0,
                    ),
                    applicationName: 'BLUEtine',
                    applicationVersion: 'Version 1.0.0',
                    applicationLegalese: 'dev'),
                title: Text('App info', style: TextStyle(fontSize: UISize.medium)),
                trailing: Icon(Icons.adaptive.arrow_forward),
              )
            ],
          ),
          //endregion

          //region VERSION
/*            SettingsSection(
                  tiles: [
                    SettingsTile(
                      title: const Divider(
                        color: Colors.transparent,
                        height: 20.0,
                      ),
                      description: FutureBuilder(
                          future: BuildEnvironment.getAppInfo(),
                          builder: (context, snapshot) {
                            return Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(snapshot.data ?? '', style: TextStyle(fontSize: TextSize.small), textAlign: TextAlign.center),
                              ],
                            );
                          }),
                    ),
                  ],
                ),*/
          //endregion
        ],
      ),
    );
  }

  //region WIDGETS
/*
  Widget _buildLanguageSelection() {
    List<DropdownMenuItem<String>> languagesItems = LanguageCode.values.map((code) {
      return DropdownMenuItem(
        value: code.name,
        alignment: AlignmentDirectional.center,
        child: Text(
          '${FlutterI18n.translate(context, 'settings.general.language.${code.name}')} ${SettingsCubit.getLanguageFlag(code.name)}',
          style: TextStyle(fontSize: UISize.medium),
        ),
      );
    }).toList();

    return DropdownButton<String>(
      isExpanded: true,
      onChanged: (locale) {
        // setState(() {
        _settings.language = locale!;
        //  });
      },
      icon: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Icon(Icons.language_rounded, size: UISize.extraLarge, color: Theme.of(context).colorScheme.secondary),
      ),
      items: languagesItems,
      value: _settings.language,
    );
  }
*/

  Widget _buildUISizeSelection() {
    List<DropdownMenuItem<String>> sizesItems = UIType.values.map((size) {
      return DropdownMenuItem(
        value: size.name,
        alignment: AlignmentDirectional.center,
        child: Text("FlutterI18n.translate(context, 'settings.general.size.${size.name}')", style: TextStyle(fontSize: UISize.medium)),
      );
    }).toList();

    return DropdownButton<String>(
      isExpanded: true,
      items: sizesItems,
      value: _settings.size,
      onChanged: (value) {
        // setState(() {
        _settings.size = value!;
        // });
      },
      icon: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Icon(Icons.format_size, size: UISize.extraLarge, color: Theme.of(context).colorScheme.secondary),
      ),
    );
  }

  Widget _buildThemeToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Switch(value: _settings.theme == ThemeMode.dark, onChanged: (isActive)=> _settings.theme = isActive ? ThemeMode.dark : ThemeMode.light)
      ],
    );
  }


  Widget _rollingIconBuilder(ThemeMode type, bool foreground) => Icon(_iconDataByValue(type), size: UISize.extraLarge);

  IconData _iconDataByValue(ThemeMode type) => switch (type) {
    ThemeMode.system => Icons.settings,
    ThemeMode.light => Icons.light_mode,
    ThemeMode.dark => Icons.dark_mode,
  };


//endregion
}
