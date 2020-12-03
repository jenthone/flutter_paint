import 'package:flutter/material.dart';

import 'const.dart';
import 'ui/screen/main_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Const.colorPrimary),
      home: MainScreen(title: 'Paint'),
    );
  }
}
