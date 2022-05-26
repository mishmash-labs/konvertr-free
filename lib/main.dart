import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';

import 'providers/category_provider.dart';
import 'screens/categories_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en',
      supportedLocales: ['en', 'es', 'fr', 'de', 'hi', 'nl', 'pl', 'pt', 'ru']);
  runApp(LocalizedApp(delegate, const KonvertrHome()));
}

class KonvertrHome extends StatelessWidget {
  const KonvertrHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizationDelegate = LocalizedApp.of(context).delegate;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => CategoriesProvider(context), lazy: false),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          localizationDelegate
        ],
        supportedLocales: localizationDelegate.supportedLocales,
        locale: localizationDelegate.currentLocale,
        home: CategoriesScreen(),
        theme: ThemeData(
            primaryColor: const Color(0xff380e7f),
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: Colors.white70)),
      ),
    );
  }
}
