import 'dart:ui';

import 'package:flutter/material.dart';

class PathHistory {
  final Paint paint;
  final offsets = <Offset>[];
  final PointMode pointMode;
  PathHistory({this.paint, this.pointMode});
}

class PathHistories {
  final _paths = <PathHistory>[];

  final _backupPaths = <PathHistory>[];

  final _backgroundPaint = Paint()..color = Colors.transparent;

  List<PathHistory> get paths => _paths;

  Paint get backgroundPaint => _backgroundPaint;

  void startSession(Paint paint, PointMode pointMode) {
    _paths.add(PathHistory(paint: paint, pointMode: pointMode));

    _backupPaths.clear();
  }

  void addPoint(Offset point) => _paths.last.offsets.add(point);

  void finishSession() {
    if (_paths.last.offsets.length == 1) {
      _paths.last.offsets.add(_paths.last.offsets.first);
    }
  }

  void clear() {
    _paths.clear();
  }

  void undo() {
    if (paths.isEmpty) {
      return;
    }

    final last = paths.removeLast();
    _backupPaths.add(last);
  }

  void redo() {
    if (_backupPaths.isEmpty) {
      return;
    }

    final last = _backupPaths.removeLast();
    _paths.add(last);
  }

  void changeBackgroundColor(Color color) => _backgroundPaint.color = color;
}
