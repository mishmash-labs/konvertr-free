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
  List<Category> value;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    value = context.read<CategoriesProvider>().categories;
    if (value.isEmpty && searchController.text == "") {
      await context.read<CategoriesProvider>().loadCategories(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    CategoriesProvider categoriesProvider = context.watch<CategoriesProvider>();

    Widget _buildTopSection() {
      return Container(
        height: 0.11 * MediaQuery.of(context).size.height,
        color: primaryColor,
        child: Column(
          children: [
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextField(
                controller: searchController,
                onChanged: (val) {
                  categoriesProvider.searchCategories(val);
                },
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "Search...",
                  prefixIcon: Icon(
                    Icons.search,
                    color: searchBarIcon,
                  ),
                  fillColor: searchBarColor,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none),
                ),
              ),
            ),
          ],
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
              letterSpacing: 1.5,
              color: searchBarColor,
              fontWeight: FontWeight.w600),
        ),
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.favorite,
              color: searchBarColor,
            ),
          )
        ],
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
      backgroundColor: secondaryColor,
      body: Container(
        child: Column(
          children: [
            _buildTopSection(),
            Expanded(child: _buildCategories()),
          ],
        ),
      ),
    );
  }
}
