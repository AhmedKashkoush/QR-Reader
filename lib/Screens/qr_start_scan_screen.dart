import 'package:flutter/material.dart';

class QRStartScanPage extends StatelessWidget {
  const QRStartScanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).iconTheme.color,
      ),
      body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: OrientationBuilder(
            builder: (context, orientation) {
              if (orientation == Orientation.landscape) {
                return const QRStartScanLandScape();
              }
              return const QRStartScanPortrait();
            },
          )),
    );
  }
}

class QRStartScanPortrait extends StatelessWidget {
  const QRStartScanPortrait({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Center(
          child: Text(
            'Move Your Camera Into The QR Code To Scan',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Icon(
          Icons.qr_code_scanner_sharp,
          size: 250,
          color: Theme.of(context).iconTheme.color!.withOpacity(0.5),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: Colors.greenAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          child: const Text('Start Scan'),
        )
      ],
    );
  }
}

class QRStartScanLandScape extends StatelessWidget {
  const QRStartScanLandScape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(
          Icons.qr_code_scanner_sharp,
          size: 250,
          color: Theme.of(context).iconTheme.color!.withOpacity(0.5),
        ),
        Wrap(
          direction: Axis.vertical,
          alignment: WrapAlignment.spaceEvenly,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 80,
          children: [
            const Text(
              'Move Your Camera Into The QR Code To Scan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: Colors.greenAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text('Start Scan'),
            ),
          ],
        )
      ],
    );
  }
}
