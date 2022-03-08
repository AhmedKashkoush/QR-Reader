import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_reader/Utils/AppSettings/Language/locales.dart';
import 'package:qr_code_reader/Utils/AppSettings/Theme/theme_provider.dart';
import 'package:qr_code_reader/Utils/AppSettings/Theme/themes.dart';

import 'Screens/home_screen.dart';
import 'Utils/AppSettings/Language/locale_provider.dart';
import 'Utils/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesApi.initPrefs();
  AppTheme.loadThemeMode();
  await AppLocales.loadLanguage();
  const SystemUiOverlayStyle _overlay = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  );
  SystemChrome.setSystemUIOverlayStyle(_overlay);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocaleProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeProvider>(context);
    Provider.of<LocaleProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Reader',
      themeMode: AppTheme.themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      locale: AppLocales.language,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      home: const HomePage(),
    );
  }
}
