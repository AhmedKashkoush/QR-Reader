import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_reader/Screens/home_screen.dart';
import 'package:qr_code_reader/Screens/scan_result_screen.dart';
import 'package:qr_code_reader/Utils/Routes/custom_routes.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanPage extends StatefulWidget {
  const QRScanPage({Key? key}) : super(key: key);

  @override
  _QRScanPageState createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  final _portraitMode = [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ];
  final _allModes = [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ];
  GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? _result;
  bool _canPop = false;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations(_portraitMode);
    super.initState();
  }

  @override
  void reassemble() {
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        if (!_canPop) _canPop = true;
        return _canPop;
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              QRView(
                key: _qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                    overlayColor: Colors.black87,
                    borderWidth: 6,
                    borderColor: Colors.greenAccent),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  onPressed: () {
                    _canPop = true;
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    this.controller!.scannedDataStream.listen(_listener);
  }

  void _listener(Barcode data){
    if (!_canPop  && mounted) {
      this._result = data;
      if (this._result != null && this._result!.format.name == 'qrcode') {
        _canPop = true;
        Navigator.of(context).pushReplacement(
          RightSlideTransition(
            page: ScanResultPage(data: this._result!, scanMode: 'QR'),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    this.controller!.dispose();
    SystemChrome.setPreferredOrientations(_allModes);
    super.dispose();
  }
}
