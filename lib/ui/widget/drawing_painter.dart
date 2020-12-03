import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../data/path_histories.dart';

class DrawingPainter extends CustomPainter {
  final PathHistories _histories;

  DrawingPainter({PathHistories histories}) : _histories = histories;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0.0, 0.0, size.width, size.height),
      _histories.backgroundPaint,
    );
    for (final path in _histories.paths) {
      canvas.drawPoints(
        path.pointMode,
        path.offsets,
        path.paint,
      );
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}
