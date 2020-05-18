import 'package:flutter/material.dart';

import 'unit.dart';

/// A class containing [Category] name, iconLocation, and List if corresponding units
class Category {
  Category({
    @required this.iconLocation,
    @required this.name,
    @required this.units,
  })  : assert(iconLocation != null),
        assert(name != null),
        assert(units != null);

  String iconLocation;
  final String name;
  final List<Unit> units;
}
