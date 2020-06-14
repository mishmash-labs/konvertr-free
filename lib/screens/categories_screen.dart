import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../components/category_card.dart';
import '../models/category.dart';
import '../providers/category_provider.dart';
import '../utils/theme.dart';

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
          cursorColor: primaryColor,
          controller: searchController,
          onChanged: (val) {
            categoriesProvider.searchCategories(val);
          },
          style: TextStyle(color: primaryColor),
          maxLines: 1,
          decoration: InputDecoration(
            isDense: true,
            hintText: "Search Categories",
            hintStyle: TextStyle(color: primaryColor),
            prefixIcon: Icon(
              Icons.search,
              color: primaryColor,
            ),
            suffixIcon: categoriesProvider.searchingCategory
                ? IconButton(
                    icon: Icon(
                      Icons.cancel,
                      color: primaryColor,
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
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          "Konvertr",
          style: GoogleFonts.roboto(
              letterSpacing: 1.7,
              color: Colors.white70,
              fontWeight: FontWeight.w400),
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
            padding: const EdgeInsets.all(4.0),
            child: CategoryCard(
              convCategory: cats,
            ),
          );
        }).toList(),
      );
    }

    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: primaryColor,
      body: Container(
        child: Column(
          children: [
            _buildTopSection(),
            Expanded(
                child: categoriesProvider.categories.isEmpty
                    ? Center(
                        child: Text(
                          "No Categories",
                          style: GoogleFonts.roboto(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                        ),
                      )
                    : _buildCategories()),
          ],
        ),
      ),
    );
  }
}
