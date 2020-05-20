import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:konvertr/models/category.dart';
import 'package:konvertr/models/unit.dart';

final _categories = <Category>[];

Future<void> _retrieveLocalCategories(BuildContext context) async {
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
  // Notify
}
