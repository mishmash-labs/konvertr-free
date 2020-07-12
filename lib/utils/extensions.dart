import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  void navigateTo(Widget destination) {
    Navigator.of(this).push(
      MaterialPageRoute(builder: (context) => destination),
    );
  }
}
