import 'package:flutter/material.dart';
import 'package:konvertr/components/category_card.dart';
import 'package:konvertr/models/category.dart';
import 'package:konvertr/providers/category_provider.dart';
import 'package:provider/provider.dart';

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

    return Scaffold();
  }
}
