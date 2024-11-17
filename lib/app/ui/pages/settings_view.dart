import 'package:blue_tine_interpreted_components/app/controller/settings/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
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

  Future<void> _removeAllData() async {
    await Hive.deleteFromDisk();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Settings'),
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
            title: Text('General', style: TextStyle(color: Theme.of(context).primaryColor)),
            tiles: [
              SettingsTile(
                leading: const Text('Dark Theme'),
                title: _buildThemeToggle(),
              ),
            ],
          ),
          //endregion

          //region INFO
          SettingsSection(
            title: Text('Info', style: TextStyle( color: Theme.of(context).primaryColor)),
            tiles: [
              SettingsTile.navigation(
                onPressed: (context) => showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        title: const Text('Do you really want to delete all data'),
                        children: [
                          Row(
                            children: [
                              ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('NO')),
                              ElevatedButton(onPressed: () => _removeAllData(), child: const Text('YES')),
                            ],
                          )
                        ],
                      );
                    }),
                title: const Text('Delete App Data', style: TextStyle(color: Colors.red)),
                trailing: Icon(Icons.adaptive.arrow_forward),
              ),
              SettingsTile.navigation(
                onPressed: (context) => showAboutDialog(
                  context: context,
                  applicationIcon: const Icon(Icons.category_outlined),
                  applicationName: 'BLUEtine',
                  applicationVersion: 'Version 1.0.0',),
                title: const Text('App info'),
                trailing: Icon(Icons.adaptive.arrow_forward),
              )
            ],
          ),
          //endregion
        ],
      ),
    );
  }

  Widget _buildThemeToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Switch(value: _settings.theme == ThemeMode.dark, onChanged: (isActive) => _settings.theme = isActive ? ThemeMode.dark : ThemeMode.light)
      ],
    );
  }

//endregion
}
