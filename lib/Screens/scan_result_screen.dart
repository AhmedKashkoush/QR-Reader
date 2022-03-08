import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_code_reader/Screens/scan_screen.dart';
import 'package:qr_code_reader/Utils/AppSettings/Language/locales.dart';
import 'package:qr_code_reader/Utils/Routes/custom_routes.dart';
import 'package:qr_code_reader/Widgets/custom_button.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanResultPage extends StatelessWidget {
  final Barcode data;
  final String scanMode;
  const ScanResultPage({Key? key, required this.data, required this.scanMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _result = data.code;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).iconTheme.color,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Opacity(
                opacity: 0.6,
                child: Text(
                  '${AppLocales.languageTranslation!["scan result"]!}', //Scan Result
                  style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.fromBorderSide(
                  BorderSide(
                    width: 2,
                    color: Colors.greenAccent.withOpacity(0.5),
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          _result!,
                          style: TextStyle(
                            color: _result.contains('http') ||
                                    _result.contains('https')
                                ? Colors.blue
                                : null,
                            decoration: _result.contains('http') ||
                                    _result.contains('https')
                                ? TextDecoration.underline
                                : TextDecoration.none,
                            fontWeight: _result.contains('http') ||
                                    _result.contains('https')
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await FlutterClipboard.copy(_result);
                      Fluttertoast.showToast(
                        msg:
                            '${AppLocales.languageTranslation!["copied to clipboard"]!}', //Copied To Clipboard
                        gravity: ToastGravity.BOTTOM,
                      );
                    },
                    icon: Icon(
                      Icons.copy,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            CustomButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  LeftSlideTransition(
                    page: ScanPage(
                      scanMode: scanMode,
                    ),
                  ),
                );
              },
              child: Text(
                '${AppLocales.languageTranslation!["scan again"]!}',
              ), //Scan Again
            ),
          ],
        ),
      ),
    );
  }
}
