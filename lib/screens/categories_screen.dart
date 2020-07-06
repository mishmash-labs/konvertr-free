import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import '../components/category_card.dart';
import '../models/category.dart';
import '../providers/category_provider.dart';
import '../providers/converter_provider.dart';
import '../utils/theme.dart';
import 'converters/generic_screen.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  TextEditingController searchController = TextEditingController();
  FocusNode searchNode = FocusNode();
  List<Category> value;

  @override
  Widget build(BuildContext context) {
    AppBar _buildAppBar() => AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          title: const Text(
            'konvertr',
            style: TextStyle(
                letterSpacing: 1.7,
                color: Colors.white70,
                fontWeight: FontWeight.w500),
          ),
          elevation: 0,
        );

    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Theme.of(context).primaryColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            floating: true,
            snap: true,
            backgroundColor: Colors.transparent,
            title: SearchBar(
                searchNode: searchNode, searchController: searchController),
          ),
          Consumer<CategoriesProvider>(
            builder: (_, cats, __) => cats.categories.isEmpty
                ? const SliverFillRemaining(
                    hasScrollBody: false, child: NoCategories())
                : CategoriesGrid(
                    cats: cats,
                    searchNode: searchNode,
                  ),
          ),
        ],
      ),
    );
  }
}

class NoCategories extends StatelessWidget {
  const NoCategories({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            MaterialCommunityIcons.swap_horizontal_variant,
            color: Colors.white54,
            size: 75,
          ),
          const SizedBox(height: 8),
          const Text(
            'no categories',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w400,
              color: Colors.white54,
            ),
          ),
        ],
      );
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key key,
    @required this.searchNode,
    @required this.searchController,
  }) : super(key: key);

  final TextEditingController searchController;
  final FocusNode searchNode;

  @override
  Widget build(BuildContext context) {
    final convCategory =
        Provider.of<CategoriesProvider>(context, listen: false);
    return Consumer<CategoriesProvider>(
      builder: (_, cat, __) => TextField(
        focusNode: searchNode,
        cursorColor: Colors.white38,
        controller: searchController,
        onChanged: convCategory.searchCategories,
        style: const TextStyle(color: Colors.white54),
        decoration: InputDecoration(
          isDense: true,
          hintText: 'search categories',
          hintStyle: const TextStyle(color: Colors.white38),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.white38,
          ),
          suffixIcon: cat.searchingCategory
              ? IconButton(
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.white38,
                  ),
                  onPressed: () {
                    convCategory.searchCategories('');
                    searchController.clear();
                    convCategory.cancelSearch();
                    searchNode.unfocus();
                  },
                )
              : null,
          fillColor: secondaryColor,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}

class CategoriesGrid extends StatelessWidget {
  const CategoriesGrid({
    Key key,
    this.cats,
    this.searchNode,
  }) : super(key: key);

  final CategoriesProvider cats;
  final FocusNode searchNode;

  @override
  Widget build(BuildContext context) => SliverGrid.count(
        crossAxisCount: 3,
        children: cats.categories
            .map((cats) => Padding(
                  padding: const EdgeInsets.all(2),
                  child: OpenContainer(
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
                            child: UnitConverter(categoryName: cats.name));
                      }),
                ))
            .toList(),
      );
}
