import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/category_screen.dart';
import 'theme/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(KonvertrHome());
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
