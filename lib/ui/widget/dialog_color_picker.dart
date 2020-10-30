import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerAlert {
  Color _currentColor = Colors.red;

  Color get currentColor => _currentColor;

  _changeColor(Color color) {
    _currentColor = color;
  }

  Future<Color> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _currentColor,
              onColorChanged: _changeColor,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(_currentColor);
              },
            ),
          ],
        );
      },
    );
  }
}
