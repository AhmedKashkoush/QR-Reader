import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_reader/Utils/AppSettings/Language/locale_provider.dart';
import 'package:qr_code_reader/Utils/AppSettings/Language/locales.dart';
import 'package:qr_code_reader/Widgets/custom_button.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../Utils/Files/file_api.dart';

class GenerateQRPage extends StatefulWidget {
  const GenerateQRPage({Key? key}) : super(key: key);

  @override
  State<GenerateQRPage> createState() => _GenerateQRPageState();
}

class _GenerateQRPageState extends State<GenerateQRPage> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey _qrBoundaryKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    Provider.of<LocaleProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        if (_controller.text.isNotEmpty) {
          await _showDialog();
          return false;
        }
        return true;
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              '${AppLocales.languageTranslation!["qr generator"]!}', //QR Generator
            ),
            leading: BackButton(
              onPressed: () async {
                if (_controller.text.isNotEmpty) {
                  await _showDialog();
                  return;
                }
                Navigator.pop(context);
              },
            ),
          ),
          body: SingleChildScrollView(
            reverse: true,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: _height * 0.2,
                  ),
                  _controller.text.isEmpty
                      ? Icon(
                          Icons.qr_code_2_outlined,
                          size: 240,
                          color: Theme.of(context)
                              .iconTheme
                              .color!
                              .withOpacity(0.3),
                        )
                      : Center(
                          child: RepaintBoundary(
                            key: _qrBoundaryKey,
                            child: QrImage(
                              data: _controller.text,
                              version: QrVersions.auto,
                              size: 205,
                              gapless: false,
                              padding: const EdgeInsets.all(8),
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              errorStateBuilder: (cxt, err) {
                                return Container(
                                  child: Center(
                                    child: Text(
                                      '${AppLocales.languageTranslation!["something went wrong"]!}', //Something went wrong
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: 55,
                    child: TextField(
                      controller: _controller,
                      onChanged: (text) {
                        setState(() {
                          //_controller.text = text;
                        });
                      },
                      decoration: InputDecoration(
                        suffixIcon: Visibility(
                          visible: _controller.text.isNotEmpty,
                          child: IconButton(
                            iconSize: 18,
                            onPressed: () {
                              setState(() {
                                _controller.clear();
                              });
                            },
                            icon: Icon(
                              Icons.close,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                        ),
                        label: Text(
                          '${AppLocales.languageTranslation!["enter data"]!}', //Enter Data
                        ),
                        contentPadding: const EdgeInsets.all(18),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomButton(
                    color: Colors.blue.shade800,
                    onPressed: _controller.text == ''
                        ? null
                        : () async {
                            _showSaveLoadingDialog();
                            final String path = await FileApi.saveQRImage(
                                fileName: _controller.text,
                                boundaryKey: _qrBoundaryKey);
                            Navigator.pop(context);
                            Fluttertoast.showToast(
                              msg:
                                  '${AppLocales.languageTranslation!["saved to"]!}: $path', //Copied To Clipboard
                              gravity: ToastGravity.BOTTOM,
                            );
                          },
                    child: Text(
                      '${AppLocales.languageTranslation!["save"]!}',
                    ), //Save
                    icon: Icons.save_alt_outlined,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    onPressed: _controller.text == ''
                        ? null
                        : () async {
                            _showLoadingDialog();
                            final String path = await FileApi.saveQRImage(
                                fileName: _controller.text,
                                boundaryKey: _qrBoundaryKey);
                            Navigator.pop(context);
                            await Share.shareFiles(
                              [path],
                            );
                          },
                    child: Text(
                      '${AppLocales.languageTranslation!["share"]!}', //Share
                    ),
                    icon: Icons.adaptive.share,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showSaveLoadingDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AlertDialog(
          content: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator.adaptive(),
              Text(
                '${AppLocales.languageTranslation!["saving"]!}', //Saving
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showLoadingDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AlertDialog(
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showDialog() async {
    FocusScope.of(context).unfocus();
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(
          '${AppLocales.languageTranslation!["back without saving?"]!}', //Back Without Saving?
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: Text(
              '${AppLocales.languageTranslation!["yes"]!}', //Yes
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              '${AppLocales.languageTranslation!["no"]!}', //No
              style: TextStyle(
                color: Colors.blue.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
