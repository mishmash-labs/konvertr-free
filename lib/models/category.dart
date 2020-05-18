import 'package:flutter/material.dart';

import 'unit.dart';

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
