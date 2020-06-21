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
    CategoriesProvider categoriesProvider = context.watch<CategoriesProvider>();

    Widget _buildTopSection() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2.0),
        child: TextField(
          focusNode: searchNode,
          cursorColor: Theme.of(context).primaryColor,
          controller: searchController,
          onChanged: (val) {
            categoriesProvider.searchCategories(val);
          },
          style: TextStyle(color: Theme.of(context).primaryColor),
          maxLines: 1,
          decoration: InputDecoration(
            isDense: true,
            hintText: "search categories",
            hintStyle: TextStyle(color: Theme.of(context).primaryColor),
            prefixIcon: Icon(
              Icons.search,
              color: Theme.of(context).primaryColor,
            ),
            suffixIcon: categoriesProvider.searchingCategory
                ? IconButton(
                    icon: Icon(
                      Icons.cancel,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      categoriesProvider.searchCategories("");
                      searchController.clear();
                      categoriesProvider.cancelSearch();
                      searchNode.unfocus();
                    },
                  )
                : null,
            fillColor: Colors.white54,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none),
          ),
        ),
      );
    }

    AppBar _buildAppBar() {
      return AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          "konvertr",
          style: TextStyle(
              letterSpacing: 1.7,
              color: Colors.white70,
              fontWeight: FontWeight.w500),
        ),
        elevation: 0.0,
      );
    }

    Widget _buildCategories() {
      return GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        childAspectRatio: 1,
        children: categoriesProvider.categories.map((Category cats) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: OpenContainer(
                closedColor: Theme.of(context).primaryColor,
                closedElevation: 0.0,
                closedBuilder: (context, action) {
                  return CategoryCard(
                    convCategory: cats,
                  );
                },
                openBuilder: (context, action) {
                  FocusScope.of(context).unfocus();

                  return ChangeNotifierProvider(
                      create: (context) =>
                          ConverterProvider(cats.units, cats.name, null, null),
                      child: UnitConverter(categoryName: cats.name));
                }),
          );
        }).toList(),
      );
    }

    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        child: Column(
          children: [
            _buildTopSection(),
            Expanded(
              child: categoriesProvider.categories.isEmpty
                  ? Center(
                      child: Text(
                        "no categories",
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                    )
                  : _buildCategories(),
            ),
          ],
        ),
      ),
    );
  }
}
