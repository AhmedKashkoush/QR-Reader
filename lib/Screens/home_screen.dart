import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_code_reader/Screens/generate_qr_screen.dart';
import 'package:qr_code_reader/Screens/qr_start_scan_screen.dart';
import 'package:qr_code_reader/Utils/Routes/custom_routes.dart';
import 'package:qr_code_reader/Widgets/code_card.dart';

import 'barcode_start_scan_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const _items = <Map<String, dynamic>>[
      {
        "icon": Icon(
          Icons.qr_code_2_outlined,
          size: 120,
        ),
        "text": 'Generate QR',
        "screen": GenerateQRPage(),
      },
      {
        "icon": Icon(
          Icons.qr_code_scanner_sharp,
          size: 120,
        ),
        "text": 'Scan QR',
        "screen": QRStartScanPage(),
      },
      {
        "icon": FaIcon(
          FontAwesomeIcons.barcode,
          size: 90,
        ),
        "text": 'Generate Barcode',
        "screen": QRStartScanPage(),
      },
      {
        "icon": FaIcon(
          FontAwesomeIcons.barcode,
          size: 90,
        ),
        "text": 'Scan Barcode',
        "screen": BarcodeStartScanPage(),
      },
    ];

    const _menuItems = ['Settings'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Reader'),
        actions: [
          PopupMenuButton(
              tooltip: 'Menu',
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              itemBuilder: (context) => _menuItems
                  .map(
                    (e) => PopupMenuItem(
                      child: Text(e),
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
                text: item['text'],
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
    // Future.delayed(const Duration(milliseconds: 150), () {
    //   Navigator.of(context).push(
    //     BottomSlideTransition(page: screen),
    //   );
    // });
    Navigator.of(context).push(
      BottomSlideTransition(page: screen),
    );
  }
}
