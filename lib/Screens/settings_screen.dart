import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_reader/Utils/AppSettings/Language/locale_provider.dart';
import 'package:qr_code_reader/Utils/AppSettings/Language/locales.dart';
import 'package:qr_code_reader/Utils/AppSettings/Theme/theme_provider.dart';
import 'package:qr_code_reader/Utils/AppSettings/Theme/themes.dart';

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
    //String _lang = 'system';
    final _theme = Provider.of<ThemeProvider>(context);
    final _lang = Provider.of<LocaleProvider>(context);
    const List<String> _fonts = ['System', 'Arial', 'Times New Roman'];
    const List<String> _sizes = [
      'Small',
      'Medium',
      'Large'
    ]; //Small, Medium, Large
    String? _selectedFont = 'System';
    double _valueIndex = 0.5;
    return Scaffold(
      appBar: AppBar(
        title: Text('${AppLocales.languageTranslation!["settings"]!}'),
      ),
      body: ListView(
        children: [
          ExpansionTile(
            title:
                Text('${AppLocales.languageTranslation!["themes"]!}'), //Themes
            leading: Icon(Icons.brightness_4_outlined),
            subtitle: Text(
              '${AppLocales.languageTranslation![AppTheme.themeMode.name.toLowerCase()]!}',
            ),
            children: [
              RadioListTile(
                title: Text(
                  '${AppLocales.languageTranslation!["system"]!}', //System
                ),
                value: ThemeMode.system.name,
                groupValue: AppTheme.themeMode.name,
                onChanged: (value) {
                  _theme.setTheme(ThemeMode.system);
                },
              ),
              RadioListTile(
                title: Text(
                  '${AppLocales.languageTranslation!["light"]!}', //Light
                ),
                value: ThemeMode.light.name,
                groupValue: AppTheme.themeMode.name,
                onChanged: (value) {
                  _theme.setTheme(ThemeMode.light);
                },
              ),
              RadioListTile(
                title: Text(
                  '${AppLocales.languageTranslation!["dark"]!}', //Dark
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
              '${AppLocales.languageTranslation!["language"]!}', //Language
            ),
            leading: Icon(Icons.translate),
            subtitle: Text(
                '${AppLocales.languageTranslation![AppLocales.languageMode.toLowerCase()]!}'),
            children: [
              RadioListTile(
                title: Text(
                  '${AppLocales.languageTranslation!["system"]!}', //System
                ),
                onChanged: (String? value) {
                  _lang.setLanguage(
                      Platform.localeName.substring(0, 2), value!);
                },
                groupValue: AppLocales.languageMode,
                value: 'system',
              ),
              RadioListTile(
                title: Text(
                  '${AppLocales.languageTranslation!["en"]!}', //En
                ),
                onChanged: (String? value) {
                  _lang.setLanguage(value!, value);
                },
                groupValue: AppLocales.languageMode,
                value: 'en',
              ),
              RadioListTile(
                title: Text(
                  '${AppLocales.languageTranslation!["ar"]!}', //Ar
                ),
                onChanged: (String? value) {
                  _lang.setLanguage(value!, value);
                },
                groupValue: AppLocales.languageMode,
                value: 'ar',
              ),
            ],
          ),
          ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            title: Text('${AppLocales.languageTranslation!["font"]!}'), //Font
            leading: FaIcon(
              FontAwesomeIcons.font,
              size: 18,
            ),
            children: [
              ListTile(
                title: Text(
                    '${AppLocales.languageTranslation!["font family"]!}'), //Font Family
                trailing: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedFont,
                    items: _fonts
                        .map<DropdownMenuItem<String>>(
                          (value) => DropdownMenuItem(
                            child: Text(value),
                            value: value,
                          ),
                        )
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedFont = value;
                      });
                    },
                  ),
                ),
              ),
              ListTile(
                title: Text(
                    '${AppLocales.languageTranslation!["font size"]!}'), //Font Size
                trailing: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Slider.adaptive(
                    value: _valueIndex,
                    label: _sizes[_valueIndex.toInt()],
                    onChanged: (double value) {
                      setState(() {
                        _valueIndex = value;
                      });
                    },
                    divisions: 2,
                    min: 0.5,
                    max: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
