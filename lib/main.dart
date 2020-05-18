import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'theme/themeChanger.dart';

void main() {
  /// This ensures that the orientation is always portrait
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(
            Konvertr(),
          ));
}

/// Unit Converter App.
/// Main Parent Widget
class Konvertr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This notifies the MaterialApp about the theme change
    return ChangeNotifierProvider(
      create: (context) => ThemeChanger(),
      child: Home(),
    );
  }
}
