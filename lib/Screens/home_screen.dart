import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_reader/Screens/generate_qr_screen.dart';
import 'package:qr_code_reader/Screens/qr_start_scan_screen.dart';
import 'package:qr_code_reader/Screens/settings_screen.dart';
import 'package:qr_code_reader/Utils/AppSettings/Language/locale_provider.dart';
import 'package:qr_code_reader/Utils/AppSettings/Language/locales.dart';
import 'package:qr_code_reader/Utils/Routes/custom_routes.dart';
import 'package:qr_code_reader/Widgets/code_card.dart';

import 'barcode_start_scan_screen.dart';
import 'generate_barcode_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const _items = <Map<String, dynamic>>[
    {
      "icon": Icon(
        Icons.qr_code_2_outlined,
        size: 120,
      ),
      "text": 'Generate QR', //Generate QR
      "screen": GenerateQRPage(),
    },
    {
      "icon": Icon(
        Icons.qr_code_scanner_sharp,
        size: 120,
      ),
      "text": 'Scan QR', //Scan QR
      "screen": QRStartScanPage(),
    },
    {
      "icon": FaIcon(
        FontAwesomeIcons.barcode,
        size: 90,
      ),
      "text": 'Generate Barcode', //Generate Barcode
      "screen": GenerateBarcodePage(),
    },
    {
      "icon": FaIcon(
        FontAwesomeIcons.barcode,
        size: 90,
      ),
      "text": 'Scan Barcode', //Scan Barcode
      "screen": BarcodeStartScanPage(),
    },
  ];

  static const _menuItems = ['Settings']; //Settings

  @override
  Widget build(BuildContext context) {
    Provider.of<LocaleProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Reader'),
        actions: [
          PopupMenuButton(
              tooltip: '${AppLocales.languageTranslation!["menu"]!}', //Menu
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onSelected: (String value) {
                final _index = _menuItems.indexOf(value);
                switch (_index) {
                  case 0:
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SettingsPage(),
                      ),
                    );
                    break;
                }
              },
              itemBuilder: (context) => _menuItems
                  .map(
                    (e) => PopupMenuItem(
                      value: e,
                      child: Text(
                        '${AppLocales.languageTranslation![e.toLowerCase()]!}',
                      ),
                    ),
                  )
                  .toList())
        ],
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        children: _items
            .map(
              (item) => CodeCard(
                icon: item['icon'],
                text:
                    '${AppLocales.languageTranslation![item['text'].toString().toLowerCase()]!}',
                onTap: () {
                  _navigateTo(item['screen'], context);
                },
              ),
            )
            .toList(),
      ),
    );
  }

  void _navigateTo(Widget screen, BuildContext context) {
    Navigator.of(context).push(
      BottomSlideTransition(page: screen),
    );
  }
}
