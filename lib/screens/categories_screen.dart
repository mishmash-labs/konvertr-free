import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/category_card.dart';
import '../components/my_appbar.dart';
import '../providers/category_provider.dart';
import '../providers/converter_provider.dart';
import '../utils/icons.dart';
import '../utils/keys.dart';
import '../utils/theme.dart';
import 'singleconvert_screen.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({key}) : super(key: key);

  TextEditingController get searchController => TextEditingController();
  FocusNode get searchNode => FocusNode();

  final List<String> choices = [
    Keys.Upgrade,
    Keys.About_Subtitle,
  ];

  final _url = Uri.parse(
      'https://play.google.com/store/apps/details?id=com.mishmash.konvertr');

  void _launchURL() async => await canLaunchUrl(_url)
      ? await launchUrl(_url)
      : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Keys.App_Title,
        actions: [
          PopupMenuButton<String>(
            color: secondaryColor,
            onSelected: (val) async {
              switch (val) {
                case Keys.About_Subtitle:
                  final packageInfo = await PackageInfo.fromPlatform();

                  return showModal(
                    context: context,
                    builder: (_) => Theme(
                      data: ThemeData(
                        brightness: Brightness.dark,
                        dialogBackgroundColor: Theme.of(context).primaryColor,
                        textTheme: const TextTheme(
                          headline5: TextStyle(color: Colors.white70),
                          bodyText2: TextStyle(color: Colors.white54),
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (states) {
                                return Colors.white70;
                              },
                            ),
                          ),
                        ),
                      ),
                      child: AboutDialog(
                        applicationIcon: const Icon(
                          KonvertrIcons.swap_horizontal_variant,
                          size: 40,
                          color: Colors.white70,
                        ),
                        applicationName: packageInfo.appName,
                        applicationVersion: packageInfo.version,
                        applicationLegalese: '© 2020 Mishmash Labs',
                      ),
                    ),
                  );
                case Keys.Upgrade:
                  _launchURL();
                  break;
                default:
              }
            },
            itemBuilder: (BuildContext context) {
              return choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(
                    translate(choice),
                    style: const TextStyle(color: Colors.white70),
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            floating: true,
            snap: true,
            backgroundColor: Colors.transparent,
            title: _SearchBar(
                searchNode: searchNode, searchController: searchController),
          ),
          Consumer<CategoriesProvider>(
            builder: (_, cats, __) => cats.categories.isEmpty
                ? const SliverFillRemaining(
                    hasScrollBody: false, child: _NoCategories())
                : _CategoriesGrid(
                    cats: cats,
                    searchNode: searchNode,
                  ),
          ),
        ],
      ),
    );
  }
}

class _NoCategories extends StatelessWidget {
  const _NoCategories({key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            KonvertrIcons.swap_horizontal_variant,
            color: Colors.white54,
            size: 75,
          ),
          const SizedBox(height: 8),
          Text(
            translate(Keys.No_Categories).toLowerCase(),
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w400,
              color: Colors.white54,
            ),
          ),
        ],
      );
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({
    key,
    @required this.searchNode,
    @required this.searchController,
  }) : super(key: key);

  final TextEditingController searchController;
  final FocusNode searchNode;

  @override
  Widget build(BuildContext context) {
    final catProvider = Provider.of<CategoriesProvider>(context, listen: false);
    return Consumer<CategoriesProvider>(
      builder: (_, cat, __) => TextField(
        focusNode: searchNode,
        cursorColor: Colors.white38,
        controller: searchController,
        onChanged: catProvider.searchCategories,
        style: const TextStyle(color: Colors.white54),
        decoration: InputDecoration(
          isDense: true,
          hintText: translate(Keys.Search_Categories).toLowerCase(),
          hintStyle: const TextStyle(color: Colors.white38),
          prefixIcon: const Icon(
            KonvertrIcons.search,
            color: Colors.white38,
          ),
          suffixIcon: cat.searchingCategory
              ? IconButton(
                  icon: const Icon(
                    KonvertrIcons.cancel,
                    color: Colors.white38,
                  ),
                  onPressed: () {
                    catProvider.searchCategories('');
                    searchController.clear();
                    catProvider.cancelSearch();
                    searchNode.unfocus();
                  },
                )
              : null,
          fillColor: secondaryColor,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}

class _CategoriesGrid extends StatelessWidget {
  const _CategoriesGrid({
    key,
    this.cats,
    this.searchNode,
  }) : super(key: key);

  final CategoriesProvider cats;
  final FocusNode searchNode;

  @override
  Widget build(BuildContext context) => SliverGrid.count(
        crossAxisCount: 3,
        children: cats.categories
            .map(
              (cats) => Padding(
                padding: const EdgeInsets.all(2),
                child: OpenContainer(
                  openColor: Theme.of(context).primaryColor,
                  openElevation: 0,
                  closedColor: Theme.of(context).primaryColor,
                  closedElevation: 0,
                  closedBuilder: (context, action) => CategoryCard(
                    convCategory: cats,
                  ),
                  openBuilder: (context, action) {
                    searchNode.unfocus();

                    return ChangeNotifierProvider(
                        create: (context) => ConverterProvider(
                            cats.units, cats.name, null, null),
                        child: SingleConverter(categoryName: cats.name));
                  },
                ),
              ),
            )
            .toList(),
      );
}
