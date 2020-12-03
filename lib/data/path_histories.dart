import 'dart:ui';

import 'package:flutter/material.dart';

class PathHistory {
  final Paint paint;
  final offsets = <Offset>[];
  final PointMode pointMode;
  PathHistory({this.paint, this.pointMode});
}

class PathHistories {
  final _pathHistories = <PathHistory>[];

  final _backupPaths = <PathHistory>[];

  final _backgroundPaint = Paint()..color = Colors.transparent;

  List<PathHistory> get paths => _pathHistories;

  Paint get backgroundPaint => _backgroundPaint;

  void startSession(Paint paint, PointMode pointMode) {
    _pathHistories.add(PathHistory(paint: paint, pointMode: pointMode));

    _backupPaths.clear();
  }

  void addPoint(Offset point) => _pathHistories.last.offsets.add(point);

  void finishSession() {
    if (_pathHistories.last.offsets.length == 1) {
      _pathHistories.last.offsets.add(_pathHistories.last.offsets.first);
    }
  }

  void clear() {
    _pathHistories.clear();
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
    _pathHistories.add(last);
  }

  // ignore: use_setters_to_change_properties
  void changeBackgroundColor(Color color) => _backgroundPaint.color = color;
}
