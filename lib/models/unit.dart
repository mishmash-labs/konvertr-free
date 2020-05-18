import 'package:flutter/material.dart';

/// Creates a [Unit] with name and conversion properties
class Unit {
  Unit({
    @required this.name,
    @required this.conversion,
  });

  Unit.fromJson(Map json)
      : assert(json['name'] != null),
        assert(json['conversion'] != null),
        name = json['name'],
        conversion = json['conversion'].toDouble();

  double conversion;
  String name;
}
