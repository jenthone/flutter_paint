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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appStateEvent = context.watch<AppStateEvent>();
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
              appStateEvent.send(ClearBoardEvent());
            },
          ),
          IconButton(
            color: colorAlert.currentColor,
            icon: Icon(
              FontAwesomeIcons.palette,
            ),
            onPressed: () {
              colorAlert.show(context, "change_color");
            },
          ),
          IconButton(
            color: Colors.pink,
            icon: Icon(
              FontAwesomeIcons.fill,
            ),
            onPressed: () {
              fillAlert.show(context, "fill_color");
            },
          ),
          IconButton(
            color: Colors.pink,
            icon: Icon(
              FontAwesomeIcons.exchangeAlt,
            ),
            onPressed: () {
              appStateEvent.send(ChangeDrawModeEvent());
            },
          ),
          IconButton(
            color: Colors.pink,
            icon: Icon(
              FontAwesomeIcons.fileExport,
            ),
            onPressed: () {
              appStateEvent.send(ExportImageEvent());
            },
          ),
          IconButton(
            color: Colors.pink,
            icon: Icon(
              FontAwesomeIcons.undo,
            ),
            onPressed: () {
              appStateEvent.send(UndoEvent());
            },
          ),
          IconButton(
            color: Colors.pink,
            icon: Icon(
              FontAwesomeIcons.redo,
            ),
            onPressed: () {
              appStateEvent.send(RedoEvent());
            },
          ),
          IconButton(
            color: Colors.pink,
            icon: Icon(
              FontAwesomeIcons.image,
            ),
            onPressed: () {
              appStateEvent.send(ChangeBackgroundEvent());
            },
          ),
          IconButton(
            color: Colors.pink,
            icon: Icon(
              FontAwesomeIcons.shareAlt,
            ),
            onPressed: () {
              appStateEvent.send(ShareEvent());
            },
          ),
        ],
      ),
    );
  }
}
