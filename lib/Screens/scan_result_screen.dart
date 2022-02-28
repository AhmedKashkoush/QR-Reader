import 'package:flutter/material.dart';
import 'package:qr_code_reader/Screens/qr_scan_screen.dart';
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
              child: Text(
                'Scan Result',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .color!
                      .withOpacity(0.6),
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
                                : Theme.of(context).textTheme.bodyText1!.color,
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
                    onPressed: () {},
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
                  LeftSlideTransition(page: const QRScanPage()),
                );
              },
              child: const Text('Scan Again'),
            ),
          ],
        ),
      ),
    );
  }
}