import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import '../../data/path_histories.dart';
import '../../utility/common.dart';
import '../../utility/event.dart';
import 'drawing_painter.dart';

class BoardWdiget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BoardWdigetState();
}

class _BoardWdigetState extends State<BoardWdiget> {
  double _strokeWidth = 3.0;
  Color _color = Colors.red;
  bool _isEraserMode = false;
  PointMode _pointMode = PointMode.polygon;
  ImageProvider _backgroundImage;

  final _histories = PathHistories();
  final _boardGlobalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _boardGlobalKey,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: _getBackgroundImage(),
          ),
        ),
        child: GestureDetector(
          onPanUpdate: _onPanUpdate,
          onPanStart: _onPanStart,
          onPanEnd: _onPanEnd,
          child: Consumer<AppStateEvent>(
            builder: (context, value, child) {
              _setupEvent(value.event);
              return ClipRect(
                child: CustomPaint(
                  size: Size.infinite,
                  painter: DrawingPainter(histories: _histories),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _setupEvent(AppEvent event) {
    if (event is ClearBoardEvent) {
      _clear();
    } else if (event is ChangeColorEvent) {
      _changeColor(event.color);
    } else if (event is ExportImageEvent) {
      _takeScreenshot();
    } else if (event is UndoEvent) {
      _undo();
    } else if (event is RedoEvent) {
      _redo();
    } else if (event is ChangeDrawModeEvent) {
      _changeDrawingMode();
    } else if (event is EraserEvent) {
      _toggleBlendMode();
    } else if (event is ShareEvent) {
      _share();
    } else if (event is ChangeBackgroundEvent) {
      _pickImage();
    } else if (event is FillEvent) {
      _changeBackgroundColor(event.color);
    }
  }

  void _onPanStart(DragStartDetails details) {
    final renderBox = context.findRenderObject() as RenderBox;
    final point = renderBox.globalToLocal(details.globalPosition);

    _histories.startSession(_createPaint(), _pointMode);
    _histories.addPoint(point);

    context.read<AppStateEvent>().send(RepaintEvent());
  }

  void _onPanUpdate(DragUpdateDetails details) {
    final renderBox = context.findRenderObject() as RenderBox;
    final point = renderBox.globalToLocal(details.globalPosition);
    _histories.addPoint(point);
    context.read<AppStateEvent>().send(RepaintEvent());
  }

  void _onPanEnd(DragEndDetails details) {
    _histories.finishSession();
    context.read<AppStateEvent>().send(RepaintEvent());
  }

  Paint _createPaint() {
    final color = _isEraserMode ? Colors.transparent : _color;
    final blendMode = _isEraserMode ? BlendMode.clear : BlendMode.srcOver;
    return Paint()
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..blendMode = blendMode
      ..color = color
      ..strokeWidth = _strokeWidth;
  }

  ImageProvider _getBackgroundImage() {
    if (_backgroundImage != null) {
      return _backgroundImage;
    }
    return AssetImage(
      pathOfImages('background.png'),
    );
  }

  void _clear() {
    _backgroundImage = null;
    if (_histories.paths.isEmpty) {
      return;
    }
    _histories.clear();
  }

  void _changeColor(Color color) => _color = color.withOpacity(_color.opacity);

  void _changeStrokeWidth(double strokeWidth) => _strokeWidth = strokeWidth;

  void _changeOpacity(double opacity) => _color = _color.withOpacity(opacity);

  void _undo() {
    _histories.undo();
  }

  void _redo() {
    _histories.redo();
  }

  void _changeDrawingMode() {
    if (_pointMode == PointMode.polygon) {
      _pointMode = PointMode.lines;
    } else if (_pointMode == PointMode.lines) {
      _pointMode = PointMode.points;
    } else {
      _pointMode = PointMode.polygon;
    }
  }

  void _takeScreenshot() {
    if (_histories.paths.isEmpty) {
      return;
    }

    takeScreenShot(_boardGlobalKey);
  }

  void _changeBackgroundColor(Color color) {
    _histories.changeBackgroundColor(color);
  }

  // I don't know why clear mode not working
  void _toggleBlendMode() {
    _isEraserMode = !_isEraserMode;
  }

  Future _pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return;
    }

    _backgroundImage = FileImage(image);
  }

  void _share() {
    Share.share('Flutter Paint');
  }
}
