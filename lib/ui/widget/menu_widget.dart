import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../utility/event.dart';
import 'dialog_color_picker.dart';

class MenuWidget extends StatefulWidget {
  MenuWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  final colorAlert = ColorPickerAlert();
  final fillAlert = ColorPickerAlert();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            color: Colors.pink,
            icon: Icon(
              FontAwesomeIcons.trashAlt,
            ),
            onPressed: () {
              context.read<AppStateEvent>().send(ClearBoardEvent());
            },
          ),
          IconButton(
            color: colorAlert.currentColor,
            icon: Icon(
              FontAwesomeIcons.palette,
            ),
            onPressed: () async {
              final color = await colorAlert.show(context);
              context.read<AppStateEvent>().send(ChangeColorEvent(color));
            },
          ),
          IconButton(
            color: Colors.pink,
            icon: Icon(
              FontAwesomeIcons.fill,
            ),
            onPressed: () async {
              final color = await fillAlert.show(context);
              context.read<AppStateEvent>().send(FillEvent(color));
            },
          ),
          IconButton(
            color: Colors.pink,
            icon: Icon(
              FontAwesomeIcons.exchangeAlt,
            ),
            onPressed: () {
              context.read<AppStateEvent>().send(ChangeDrawModeEvent());
            },
          ),
          IconButton(
            color: Colors.pink,
            icon: Icon(
              FontAwesomeIcons.fileExport,
            ),
            onPressed: () {
              context.read<AppStateEvent>().send(ExportImageEvent());
            },
          ),
          IconButton(
            color: Colors.pink,
            icon: Icon(
              FontAwesomeIcons.undo,
            ),
            onPressed: () {
              context.read<AppStateEvent>().send(UndoEvent());
            },
          ),
          IconButton(
            color: Colors.pink,
            icon: Icon(
              FontAwesomeIcons.redo,
            ),
            onPressed: () {
              context.read<AppStateEvent>().send(RedoEvent());
            },
          ),
          IconButton(
            color: Colors.pink,
            icon: Icon(
              FontAwesomeIcons.image,
            ),
            onPressed: () {
              context.read<AppStateEvent>().send(ChangeBackgroundEvent());
            },
          ),
          IconButton(
            color: Colors.pink,
            icon: Icon(
              FontAwesomeIcons.shareAlt,
            ),
            onPressed: () {
              context.read<AppStateEvent>().send(ShareEvent());
            },
          ),
        ],
      ),
    );
  }
}
