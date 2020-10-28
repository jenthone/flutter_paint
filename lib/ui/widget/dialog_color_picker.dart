import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

import '../../utility/event.dart';

class ColorPickerAlert {
  Color _currentColor = Colors.red;

  Color get currentColor => _currentColor;

  _changeColor(Color color) {
    _currentColor = color;
  }

  void show(BuildContext context, String type) {
    showDialog(
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
                final appStateEvent = context.read<AppStateEvent>();
                if (type == "change_color") {
                  appStateEvent.send(ChangeColorEvent(_currentColor));
                } else {
                  appStateEvent.send(FillEvent(_currentColor));
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
