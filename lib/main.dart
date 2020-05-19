import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:konvertr/theme/themes.dart';

import 'screens/category_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) => runApp(
      KonvertrHome(),
    ),
  );
}

class KonvertrHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getDarkTheme(),
      title: 'Unit Converter',
      home: CategoryScreen(),
    );
  }
}
