import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../models/category.dart';
import '../models/unit.dart';

class CategoriesProvider extends ChangeNotifier {
  CategoriesProvider(BuildContext context) {
    loadCategories(context);
  }

  List<Category> _allCategories = <Category>[];
  List<Category> _categories = <Category>[];
  bool _searchingCategory = false;

  List<Category> get categories => _categories;

  bool get searchingCategory => _searchingCategory;

  IconData getIconForCategory(String categoryName) {
    switch (categoryName) {
      case 'angle':
        return FontAwesome5Solid.drafting_compass;
        break;
      case 'area':
        return FontAwesome.area_chart;
        break;
      case 'electric current':
        return FontAwesome5Solid.plug;
        break;
      case 'data transfer':
        return FontAwesome.download;
        break;
      case 'data':
        return FontAwesome.database;
        break;
      case 'energy':
        return FontAwesome5Solid.bolt;
        break;
      case 'force':
        return Ionicons.md_rocket;
        break;
      case 'frequency':
        return MaterialCommunityIcons.radio_tower;
        break;
      case 'fuel economy':
        return FontAwesome5Solid.gas_pump;
        break;
      case 'illumination':
        return FontAwesome5Solid.lightbulb;
        break;
      case 'length':
        return FontAwesome5Solid.ruler_combined;
        break;
      case 'luminance':
        return FontAwesome5Solid.sun;
        break;
      case 'mass':
        return FontAwesome5Solid.weight;
        break;
      case 'pressure':
        return MaterialCommunityIcons.pipe;
        break;
      case 'sound':
        return MaterialCommunityIcons.volume_high;
        break;
      case 'speed':
        return Ionicons.ios_speedometer;
        break;
      case 'temperature':
        return FontAwesome5Solid.thermometer_full;
        break;
      case 'time':
        return FontAwesome5Solid.clock;
        break;
      case 'torque':
        return FontAwesome5Solid.wrench;
        break;
      case 'typography':
        return MaterialCommunityIcons.format_font;
        break;
      case 'volume':
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
