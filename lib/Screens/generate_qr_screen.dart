import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_reader/Utils/AppSettings/Language/locale_provider.dart';
import 'package:qr_code_reader/Utils/AppSettings/Language/locales.dart';
import 'package:qr_code_reader/Widgets/custom_button.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQRPage extends StatefulWidget {
  const GenerateQRPage({Key? key}) : super(key: key);

  @override
  State<GenerateQRPage> createState() => _GenerateQRPageState();
}

class _GenerateQRPageState extends State<GenerateQRPage> {
  final TextEditingController _controller = TextEditingController();
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
                '${AppLocales.languageTranslation!["qr generator"]!}'), //QR Generator
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
                    height: _height * 0.20,
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
                          child: QrImage(
                            data: _controller.text,
                            version: QrVersions.auto,
                            size: 205,
                            gapless: false,
                            foregroundColor: Theme.of(context).iconTheme.color,
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
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: _controller,
                      onChanged: (text) {
                        setState(() {
                          //_controller.text = text;
                        });
                      },
                      decoration: InputDecoration(
                        suffix: Visibility(
                          visible: _controller.text.isNotEmpty,
                          child: IconButton(
                            iconSize: 18,
                            onPressed: () {
                              setState(() {
                                _controller.clear();
                                FocusScope.of(context).unfocus();
                              });
                            },
                            icon: Icon(
                              Icons.close,
                            ),
                          ),
                        ),
                        label: Text(
                            '${AppLocales.languageTranslation!["enter data"]!}'), //Enter Data
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
                    onPressed: _controller.text == '' ? null : () {},
                    child: Text(
                        '${AppLocales.languageTranslation!["save"]!}'), //Save
                    icon: Icons.save_alt_outlined,
                  ),
                ],
              ),
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
            '${AppLocales.languageTranslation!["back without saving?"]!}'), //Back Without Saving?
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
