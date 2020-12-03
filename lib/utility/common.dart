import 'dart:io';
import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toast/toast.dart';

void takeScreenShot(GlobalKey key) async {
  final permission =
      Platform.isAndroid ? PermissionGroup.storage : PermissionGroup.photos;
  var permissions = await PermissionHandler().requestPermissions([permission]);
  if (PermissionStatus.disabled == permissions[permission]) {
    await PermissionHandler().openAppSettings();
    return;
  }
  if (PermissionStatus.granted != permissions[permission]) {
    return;
  }
  RenderRepaintBoundary boundary = key.currentContext.findRenderObject();
  final image = await boundary.toImage();
  final byteData = await image.toByteData(format: ImageByteFormat.png);
  var pngBytes = byteData.buffer.asUint8List();

  await ImageGallerySaver.save(pngBytes);

  Toast.show(
    'Save image success to gallery',
    key.currentContext,
    duration: Toast.LENGTH_LONG,
    gravity: Toast.BOTTOM,
  );
}

String pathOfImages(String name) {
  return 'assets/images/$name';
}
