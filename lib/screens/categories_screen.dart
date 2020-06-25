import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/category_card.dart';
import '../models/category.dart';
import '../providers/category_provider.dart';
import '../providers/converter_provider.dart';
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
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
          SliverAppBar(
            elevation: 0,
            floating: true,
            snap: true,
            title: SearchBar(
                searchNode: searchNode, searchController: searchController),
          ),
        ],
        body: Column(
          children: [
            Consumer<CategoriesProvider>(
              builder: (_, cats, __) => Expanded(
                child: cats.categories.isEmpty
                    ? const NoCategories()
                    : CategoriesGrid(
                        cats: cats,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NoCategories extends StatelessWidget {
  const NoCategories({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => const Center(
        child: Text(
          'no categories',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
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
        cursorColor: Theme.of(context).primaryColor,
        controller: searchController,
        onChanged: convCategory.searchCategories,
        style: TextStyle(color: Theme.of(context).primaryColor),
        decoration: InputDecoration(
          isDense: true,
          hintText: 'search categories',
          hintStyle: TextStyle(color: Theme.of(context).primaryColor),
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).primaryColor,
          ),
          suffixIcon: cat.searchingCategory
              ? IconButton(
                  icon: Icon(
                    Icons.cancel,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    convCategory.searchCategories('');
                    searchController.clear();
                    convCategory.cancelSearch();
                    searchNode.unfocus();
                  },
                )
              : null,
          fillColor: Colors.white54,
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
  }) : super(key: key);

  final CategoriesProvider cats;

  @override
  Widget build(BuildContext context) => GridView.count(
        shrinkWrap: true,
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
                      openBuilder: (context, action) => ChangeNotifierProvider(
                          create: (context) => ConverterProvider(
                              cats.units, cats.name, null, null),
                          child: UnitConverter(categoryName: cats.name))),
                ))
            .toList(),
      );
}
