import 'package:flutter/material.dart';

class GenerateQRPage extends StatefulWidget {
  const GenerateQRPage({Key? key}) : super(key: key);

  @override
  State<GenerateQRPage> createState() => _GenerateQRPageState();
}

class _GenerateQRPageState extends State<GenerateQRPage> {
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('QR Generator'),
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
                Icon(
                  Icons.qr_code_2_outlined,
                  size: 240,
                  color: Theme.of(context).iconTheme.color!.withOpacity(0.3),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextField(
                  decoration: InputDecoration(
                    label: const Text('Enter Data'),
                    contentPadding: const EdgeInsets.all(18),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
