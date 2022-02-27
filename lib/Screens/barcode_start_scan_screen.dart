import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BarcodeStartScanPage extends StatelessWidget {
  const BarcodeStartScanPage({Key? key}) : super(key: key);

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
                return const BarcodeStartScanLandScape();
              }
              return const BarcodeStartScanPortrait();
            },
          )),
    );
  }
}

class BarcodeStartScanPortrait extends StatelessWidget {
  const BarcodeStartScanPortrait({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Center(
          child: Text(
            'Move Your Camera Into The Barcode To Scan',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Center(
          child: FaIcon(
            FontAwesomeIcons.barcode,
            size: 230,
            color: Theme.of(context).iconTheme.color!.withOpacity(0.5),
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
        )
      ],
    );
  }
}

class BarcodeStartScanLandScape extends StatelessWidget {
  const BarcodeStartScanLandScape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FaIcon(
          FontAwesomeIcons.barcode,
          size: 220,
          color: Theme.of(context).iconTheme.color!.withOpacity(0.5),
        ),
        Wrap(
          direction: Axis.vertical,
          alignment: WrapAlignment.spaceEvenly,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 80,
          children: [
            const Text(
              'Move Your Camera Into The Barcode To Scan',
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
