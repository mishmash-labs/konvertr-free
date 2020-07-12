import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_translate/flutter_translate.dart';

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
      case 'charge':
        return MaterialCommunityIcons.battery_charging;
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
      case 'flow':
        return MaterialCommunityIcons.water_pump;
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
      case 'power':
        return FontAwesome5Solid.power_off;
        break;
      case 'pressure':
        return MaterialCommunityIcons.pipe;
        break;
      case 'radiation':
        return MaterialCommunityIcons.radioactive;
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
    final data = const JsonDecoder().convert(await json);

    data.keys.forEach((key) {
      final List<Unit> units =
          data[key].map<Unit>((data) => Unit.fromJson(data)).toList();

      final category = Category(
          name: key,
          units: units..sort((a, b) => a.name.compareTo(b.name)),
          icon: getIconForCategory(key));

      _categories.add(category);
    });
    _allCategories = _categories
      ..sort((a, b) {
        final translatedA = translate(a.name).toLowerCase();
        final translatedB = translate(b.name).toLowerCase();
        return translatedA.compareTo(translatedB);
      });
    notifyListeners();
  }

  void searchCategories(String searchTerm) {
    searchTerm.isNotEmpty
        ? _searchingCategory = true
        : _searchingCategory = false;

    _categories = _allCategories.where((element) {
      final translated = translate(element.name);
      return translated.toLowerCase().contains(searchTerm.toLowerCase());
    }).toList();

    notifyListeners();
  }

  void cancelSearch() {
    _searchingCategory = false;
    notifyListeners();
  }
}
