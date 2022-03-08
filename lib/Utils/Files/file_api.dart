import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

class FileApi{

  static Future<Uint8List> convertToImage({required GlobalKey boundaryKey}) async {
    final RenderRepaintBoundary boundary = boundaryKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary;
    final ui.Image image = await boundary.toImage();
    final ByteData? byteData =
    await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();
    return pngBytes;
  }

  static Future<String> saveQRImage({required GlobalKey boundaryKey,required String fileName}) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = directory.path;
    final File file = await File('$path/$fileName.png').create();
    final Uint8List bytes = await convertToImage(boundaryKey: boundaryKey);
    file.writeAsBytesSync(bytes);
    return '$path/$fileName.png';
  }
}