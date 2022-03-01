import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_reader/Utils/AppSettings/theme_provider.dart';
import 'package:qr_code_reader/Utils/themes.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    String _dev = Platform.localeName.substring(0, 2);
    //_lang = Localizations.localeOf(context).languageCode;
    String _lang = 'system';
    final _theme = Provider.of<ChangeTheme>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ExpansionTile(
            title: Text('Themes'),
            leading: Icon(Icons.brightness_4_outlined),
            subtitle: Text(
              AppTheme.themeMode.name,
            ),
            children: [
              RadioListTile(
                title: Text(
                  ThemeMode.system.name,
                ),
                value: ThemeMode.system.name,
                groupValue: AppTheme.themeMode.name,
                onChanged: (value) {
                  _theme.setTheme(ThemeMode.system);
                },
              ),
              RadioListTile(
                title: Text(
                  ThemeMode.light.name,
                ),
                value: ThemeMode.light.name,
                groupValue: AppTheme.themeMode.name,
                onChanged: (value) {
                  _theme.setTheme(ThemeMode.light);
                },
              ),
              RadioListTile(
                title: Text(
                  ThemeMode.dark.name,
                ),
                value: ThemeMode.dark.name,
                groupValue: AppTheme.themeMode.name,
                onChanged: (value) {
                  _theme.setTheme(ThemeMode.dark);
                },
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
              'Language',
            ),
            leading: Icon(Icons.translate),
            children: [
              RadioListTile(
                title: Text(
                  'system',
                ),
                onChanged: (value) {},
                groupValue: _lang,
                value: 'system',
              ),
              RadioListTile(
                title: Text(
                  'En',
                ),
                onChanged: (value) {},
                groupValue: _lang,
                value: 'en',
              ),
              RadioListTile(
                title: Text(
                  'Ar',
                ),
                onChanged: (value) {},
                groupValue: _lang,
                value: 'ar',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
