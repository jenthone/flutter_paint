import 'package:flutter/material.dart';
import '../widget/board_widget.dart';
import '../widget/menu_widget.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            BoardWdiget(),
            Positioned(
              right: 0,
              child: MenuWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
