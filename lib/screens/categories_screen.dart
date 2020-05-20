import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:konvertr/components/category_card.dart';
import 'package:konvertr/utils/theme.dart';
import 'package:provider/provider.dart';

import '../models/category.dart';
import '../providers/category_provider.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Category> value;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    value = context.read<CategoriesProvider>().categories;
    if (value.isEmpty) {
      await context.read<CategoriesProvider>().loadCategories(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    CategoriesProvider categoriesProvider = context.watch<CategoriesProvider>();

    Widget _buildTopSection() {
      return Container(
        color: mainPageTopColor,
        child: Column(
          children: [
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextField(
                onChanged: (val) {
                  categoriesProvider.searchCategories(val);
                },
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "Search...",
                  prefixIcon: Icon(
                    Icons.search,
                    color: searchBarDarkGrey,
                  ),
                  fillColor: Color(0xffe6e7eb),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide.none),
                ),
              ),
            ),
            SizedBox(height: 30.0)
          ],
        ),
      );
    }

    AppBar _buildAppBar() {
      return AppBar(
        backgroundColor: mainPageTopColor,
        centerTitle: true,
        title: Text(
          "Konvertr",
          style: GoogleFonts.roboto(
              letterSpacing: 1.5,
              color: Colors.white,
              fontWeight: FontWeight.w600),
        ),
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.favorite,
              color: Colors.white,
            ),
          )
        ],
      );
    }

    // Widget _buildCategories() {
    //   return GridView.count(
    //     shrinkWrap: true,
    //     crossAxisCount: 3,
    //     childAspectRatio: 1,
    //     children: categoriesProvider.categories.map((Category cats) {
    //       return CategoryTile(category: cats);
    //     }).toList(),
    //   );
    // }

    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        child: Column(
          children: [
            _buildTopSection(),
            // _buildCategories(),
          ],
        ),
      ),
    );
  }
}
