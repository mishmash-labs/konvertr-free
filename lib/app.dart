import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/category_screen.dart';
import 'theme/themeChanger.dart';

/// Contains the MaterialApp widget
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.themeData,
      title: 'Unit Converter',
      home: CategoryScreen(),
      routes: <String, WidgetBuilder>{
        '/CategoryScreen': (BuildContext context) => CategoryScreen()
      },
    );
  }
}
