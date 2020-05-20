import 'package:flutter/material.dart';

import 'unit.dart';

class Category {
  Category({
    @required this.name,
    @required this.units,
  })  : assert(name != null),
        assert(units != null);

  final String name;
  final List<Unit> units;
}