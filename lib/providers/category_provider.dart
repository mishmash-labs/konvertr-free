import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/unit.dart';

class CategoriesProvider extends ChangeNotifier {
  List<Category> _categories = <Category>[];
  List<Category> _allCategories = <Category>[];

  List<Category> get categories => _categories;

  Future<void> loadCategories(BuildContext context) async {
    final json =
        DefaultAssetBundle.of(context).loadString('assets/data/units.json');
    final data = JsonDecoder().convert(await json);
    if (data is! Map) {
      throw ('Json is not a Map');
    }
    data.keys.forEach((key) {
      final List<Unit> units =
          data[key].map<Unit>((dynamic data) => Unit.fromJson(data)).toList();

      var category = Category(name: key, units: units);

      _categories.add(category);
    });
    _allCategories = _categories;
    notifyListeners();
  }

  Future<void> searchCategories(String searchTerm) async {
    List<Category> _searchedList = List();

    _searchedList = _allCategories
        .where((element) =>
            element.name.toLowerCase().contains(searchTerm.toLowerCase()))
        .toList();
    _categories = _searchedList;
    notifyListeners();
  }
}
