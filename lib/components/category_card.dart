import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../models/category.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({key, this.convCategory}) : super(key: key);

  final Category convCategory;

  @override
  Widget build(BuildContext context) => Card(
        color: Theme.of(context).primaryColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1.5, color: Colors.white10),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              convCategory.icon,
              color: Colors.white30,
              size: 0.05625 * MediaQuery.of(context).size.height,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                translate(convCategory.name),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white54,
                ),
              ),
            )
          ],
        ),
      );
}
