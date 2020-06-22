import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    Widget _buildTopSection() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2.0),
        child: Consumer<CategoriesProvider>(
          builder: (_, cat, __) => TextField(
            focusNode: searchNode,
            cursorColor: Get.theme.primaryColor,
            controller: searchController,
            onChanged: (val) {
              context.read<CategoriesProvider>().searchCategories(val);
            },
            style: TextStyle(color: Get.theme.primaryColor),
            maxLines: 1,
            decoration: InputDecoration(
              isDense: true,
              hintText: "search categories",
              hintStyle: TextStyle(color: Get.theme.primaryColor),
              prefixIcon: Icon(
                Icons.search,
                color: Get.theme.primaryColor,
              ),
              suffixIcon: cat.searchingCategory
                  ? IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Get.theme.primaryColor,
                      ),
                      onPressed: () {
                        context.read<CategoriesProvider>().searchCategories("");
                        searchController.clear();
                        context.read<CategoriesProvider>().cancelSearch();
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
        ),
      );
    }

    AppBar _buildAppBar() {
      return AppBar(
        backgroundColor: Get.theme.primaryColor,
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
      return Consumer<CategoriesProvider>(
        builder: (_, cats, __) => GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          childAspectRatio: 1,
          children: cats.categories.map((Category cats) {
            return Padding(
              padding: const EdgeInsets.all(2.0),
              child: OpenContainer(
                  closedColor: Get.theme.primaryColor,
                  closedElevation: 0.0,
                  closedBuilder: (context, action) {
                    return CategoryCard(
                      convCategory: cats,
                    );
                  },
                  openBuilder: (context, action) {
                    FocusScope.of(context).unfocus();
                    return ChangeNotifierProvider(
                        create: (context) => ConverterProvider(
                            cats.units, cats.name, null, null),
                        child: UnitConverter(categoryName: cats.name));
                  }),
            );
          }).toList(),
        ),
      );
    }

    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Get.theme.primaryColor,
      body: Container(
        child: Column(
          children: [
            _buildTopSection(),
            Consumer<CategoriesProvider>(
              builder: (_, cats, __) => Expanded(
                child: cats.categories.isEmpty
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
            ),
          ],
        ),
      ),
    );
  }
}
