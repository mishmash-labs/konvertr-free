import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../models/category.dart';
import '../models/unit.dart';

class CategoriesProvider extends ChangeNotifier {
  List<Category> _allCategories = <Category>[];
  List<Category> _categories = <Category>[];
  bool _searchingCategory = false;

  List<Category> get categories => _categories;
  bool get searchingCategory => _searchingCategory;

  CategoriesProvider(BuildContext context) {
    loadCategories(context);
  }

  IconData getIconForCategory(String categoryName) {
    switch (categoryName) {
      case 'Area':
        return FontAwesome.area_chart;
        break;
      case 'Data Transfer':
        return FontAwesome.download;
        break;
      case 'Data':
        return FontAwesome.database;
        break;
      case 'Energy':
        return FontAwesome5Solid.plug;
        break;
      case 'Frequency':
        return MaterialCommunityIcons.radio_tower;
        break;
      case 'Fuel Economy':
        return FontAwesome5Solid.gas_pump;
        break;
      case 'Length':
        return FontAwesome5Solid.ruler_combined;
        break;
      case 'Mass':
        return FontAwesome5Solid.weight;
        break;
      case 'Pressure':
        return MaterialCommunityIcons.pipe;
        break;
      case 'Speed':
        return Ionicons.ios_speedometer;
        break;
      case 'Temperature':
        return FontAwesome5Solid.thermometer_full;
        break;
      case 'Time':
        return FontAwesome5Solid.clock;
        break;
      case 'Volume':
        return MaterialCommunityIcons.beaker;
        break;
      default:
        return FontAwesome.star_half_empty;
    }
  }

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

      var category =
          Category(name: key, units: units, icon: getIconForCategory(key));

      _categories.add(category);
    });
    _allCategories = _categories;
    notifyListeners();
  }

  Future<void> searchCategories(String searchTerm) async {
    List<Category> _searchedList = List();

    if (searchTerm.isNotEmpty) {
      _searchingCategory = true;
    } else
      _searchingCategory = false;

    _searchedList = _allCategories
        .where((element) =>
            element.name.toLowerCase().contains(searchTerm.toLowerCase()))
        .toList();
    _categories = _searchedList;
    notifyListeners();
  }

  void cancelSearch() {
    _searchingCategory = false;
    notifyListeners();
  }
}
