import 'package:flutter/material.dart';

import 'unit.dart';

class Category {
  Category({
    @required this.name,
    @required this.units,
    @required this.icon,
  });

  final IconData icon;
  final String name;
  final List<Unit> units;
}
