import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_reader/Utils/Routes/themes.dart';

import 'Screens/home_screen.dart';

void main() {
  const SystemUiOverlayStyle _overlay = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  );
  SystemChrome.setSystemUIOverlayStyle(_overlay);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Reader',
      themeMode: AppTheme.themeMode,
      theme: AppTheme.lightTheme,
      home: const HomePage(),
    );
  }
}
