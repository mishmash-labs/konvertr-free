import 'package:flutter/material.dart';

import '../screens/unit_screen.dart';
import '../models/category.dart';

final _borderRadius = BorderRadius.circular(12.5);
final _padding8 = EdgeInsets.all(8.0);

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    @required this.category,
  }) : assert(category != null);

  final Category category;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    void _openConverterRoute(Category categoryUnit) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => UnitConverter(category: categoryUnit),
      ));
    }

    return Padding(
      padding: _padding8,
      child: Container(
        height: 0.16 * height,
        width: 0.15 * height,
        decoration: BoxDecoration(
          color: Theme.of(context).buttonColor,
          borderRadius: _borderRadius,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(46, 46, 46, 0.05),
              offset: Offset(0.0, 0.0),
              spreadRadius: 5,
              blurRadius: 10,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              _openConverterRoute(category);
            },
            borderRadius: _borderRadius,
            splashColor: Theme.of(context).splashColor,
            highlightColor: Theme.of(context).highlightColor,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 0.0022 * height),
                  Padding(
                    padding: _padding8,
                    child: Image.asset(
                      category.iconLocation,
                      height: 0.072 * height,
                      width: 0.072 * height,
                    ),
                  ),
                  SizedBox(height: 0.0022 * height),
                  Text(
                    category.name,
                    style: Theme.of(context).textTheme.caption,
                  ),
                  SizedBox(height: 0.0056 * height),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
