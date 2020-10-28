import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'utility/event.dart';

void main() => runApp(
      ChangeNotifierProvider(
        child: App(),
        create: (context) => AppStateEvent(),
      ),
    );
