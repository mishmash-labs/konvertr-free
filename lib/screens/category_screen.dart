import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../component/category_tile.dart';
import '../models/category.dart';
import '../models/unit.dart';
import '../theme/themes.dart';

/// Builds the main screen.
/// Containing the title, buttons and GridView
class CategoryScreen extends StatefulWidget {
  const CategoryScreen();

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  /// Creates a list of [Category] widgets for storing each category information

  final _categories = <Category>[];

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (_categories.isEmpty) {
      await _retrieveLocalCategories();
    }
  }

  Future<void> _retrieveLocalCategories() async {
    final json =
        DefaultAssetBundle.of(context).loadString('assets/data/units.json');
    final data = JsonDecoder().convert(await json);
    if (data is! Map) {
      throw ('Json is not a Map');
    }
    data.keys.forEach((key) {
      final List<Unit> units =
          data[key].map<Unit>((dynamic data) => Unit.fromJson(data)).toList();

      var category = Category(
          iconLocation: "assets/icons/" + key + ".png",
          name: key,
          units: units);

      setState(() {
        _categories.add(category);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    Widget _buildCategoryGrid() {
      return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1,
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 1.0),
        children: _categories.map((Category c) {
          return CategoryTile(category: c);
        }).toList(),
      );
    }

    Widget _topBar() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 0.06 * height),
          Row(
            children: [
              SizedBox(width: 0.1 * width),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Unit",
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontSize: 0.055 * height),
                  ),
                  Text(
                    "Converter",
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontSize: 0.055 * height),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 0.04 * height),
          Container(
            width: 0.4 * width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(70),
              color: Theme.of(context).accentColor,
            ),
            height: 0.04 * height,
            child: Center(
              child: Text(
                "Select a Category",
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(fontSize: 0.019 * height),
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Expanded(flex: 2, child: _topBar()),
          Expanded(flex: 4, child: _buildCategoryGrid()),
        ],
      )),
    );
  }
}
