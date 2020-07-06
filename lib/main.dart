import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'providers/category_provider.dart';
import 'screens/categories_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(KonvertrHome());
}

class KonvertrHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => CategoriesProvider(context), lazy: false),
      ],
      child: MaterialApp(
        home: CategoriesScreen(),
        theme: ThemeData(
          primaryColor: Color(0xff380e7f),
          accentColor: Colors.white70,
        ),
      ),
    );
  }
}
