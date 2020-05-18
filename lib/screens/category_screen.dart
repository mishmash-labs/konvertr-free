import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../component/category_tile.dart';
import '../models/category.dart';
import '../models/unit.dart';
import '../theme/theme_changer.dart';
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

  /// This method parses JSON file and add to the categories list
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
          iconLocation: "assets/icons/dark/" + key + ".png",
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
    final theme = Provider.of<ThemeChanger>(context);
    AppTheme appTheme = AppTheme();
    bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    ///Below two methods update the components as per theme
    ///
    /// Updates the iconLocation according to theme
    void updateCategoryIcons() {
      setState(() {
        for (var i = 0; i < _categories.length; ++i) {
          _categories[i].iconLocation = isDarkTheme
              ? "assets/icons/dark/" + _categories[i].name + ".png"
              : "assets/icons/light/" + _categories[i].name + ".png";
        }
      });
    }

    ///
    /// Builds Category grid according theme
    ///
    Widget _buildCategoryGrid() {
      updateCategoryIcons();
      return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1,
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 1.0),
        children: _categories.map((Category c) {
          return CategoryTile(category: c);
        }).toList(),
      );
    }

    ///
    /// Builds the top bar with title and buttons
    ///
    Widget _topBar() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          /// Spacer
          SizedBox(height: 0.02401359593392630365 * height),

          /// Theme toggle icon
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  theme.themeData = isDarkTheme
                      ? appTheme.getLightTheme()
                      : appTheme.getDarkTheme();
                },
                padding: EdgeInsets.all(0.0),
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                icon: Icon(
                  Icons.brightness_medium,
                  size: 0.03335451080050826027 * height,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
          ),

          /// Spacer
          SizedBox(height: 0.01901359593392630365 * height),

          /// Heading Container
          Row(
            children: [
              SizedBox(width: 0.09722222222222221952 * width),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Unit",
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontSize: 0.05559085133418043379 * height),
                  ),
                  Text(
                    "Converter",
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontSize: 0.05559085133418043379 * height),
                  ),
                ],
              ),
            ],
          ),

          /// Spacer
          SizedBox(height: 0.03901359593392630365 * height),

          /// Container for sub-heading
          Container(
            width: 0.43472222222222220737 * width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(70),
              color: Theme.of(context).accentColor,
            ),
            height: 0.04447268106734434703 * height,
            child: Center(
              child: Text(
                "Select a Category",
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(fontSize: 0.01890088945362134749 * height),
              ),
            ),
          ),

          /// Spacer
          SizedBox(height: 0.02035451080050826027 * height),
        ],
      );
    }

    ///
    /// Builds the final screen
    ///
    Widget listView() {
      return Column(
        children: <Widget>[
          Expanded(flex: 3, child: _topBar()),
          Expanded(flex: 5, child: _buildCategoryGrid()),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: listView(),
      ),
    );
  }
}
