import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../models/category.dart';
import '../models/unit.dart';
import '../utils/icons.dart';

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
        return KonvertrIcons.angle;
        break;
      case 'area':
        return KonvertrIcons.area;
        break;
      case 'charge':
        return KonvertrIcons.charge;
        break;
      case 'electric current':
        return KonvertrIcons.current;
        break;
      case 'data transfer':
        return KonvertrIcons.transfer;
        break;
      case 'data':
        return KonvertrIcons.data;
        break;
      case 'energy':
        return KonvertrIcons.energy;
        break;
      case 'flow':
        return KonvertrIcons.flow;
        break;
      case 'force':
        return KonvertrIcons.force;
        break;
      case 'frequency':
        return KonvertrIcons.frequency;
        break;
      case 'fuel economy':
        return KonvertrIcons.economy;
        break;
      case 'illumination':
        return KonvertrIcons.illumination;
        break;
      case 'length':
        return KonvertrIcons.length;
        break;
      case 'luminance':
        return KonvertrIcons.luminance;
        break;
      case 'mass':
        return KonvertrIcons.mass;
        break;
      case 'power':
        return KonvertrIcons.power;
        break;
      case 'pressure':
        return KonvertrIcons.pressure;
        break;
      case 'radiation':
        return KonvertrIcons.radiation;
        break;
      case 'sound':
        return KonvertrIcons.sound;
        break;
      case 'speed':
        return KonvertrIcons.speed;
        break;
      case 'temperature':
        return KonvertrIcons.temperature;
        break;
      case 'time':
        return KonvertrIcons.time;
        break;
      case 'torque':
        return KonvertrIcons.torque;
        break;
      case 'typography':
        return KonvertrIcons.typography;
        break;
      case 'volume':
        return KonvertrIcons.volume;
        break;
      default:
        return KonvertrIcons.heart;
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
