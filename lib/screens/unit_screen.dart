import 'package:flutter/material.dart';

import '../component/unitCon_Logic.dart';
import '../models/category.dart';

class UnitConverter extends StatefulWidget {
  const UnitConverter({
    Key key,
    @required this.category,
  })  : assert(category != null),
        super(key: key);

  final Category category;

  @override
  _UnitConverterState createState() => _UnitConverterState();
}

class _UnitConverterState extends State<UnitConverter> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    Widget unitInputContainer() {
      return Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(46, 46, 46, 0.05),
              offset: Offset(0.0, 0.0),
              spreadRadius: 5,
              blurRadius: 10,
            ),
          ],
        ),
        height: 0.61 * height,
        width: 0.79 * width,
        child: UnitConFgUI(
          units: widget.category.units,
        ),
      );
    }

    Widget _topDesign() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(height: 0.025 * height),
            ],
          ),
          Row(
            children: <Widget>[
              SizedBox(width: height / 50),
              IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    size: 0.033 * height,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              SizedBox(width: height / 4),
              SizedBox(width: 0.0),
            ],
          ),
          SizedBox(height: 0.046 * height),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(width: 0.0),
              Text(
                widget.category.name,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontSize: 0.058 * height),
              ),
              SizedBox(width: 0.033 * width),
              Image.asset(
                'assets/icons/${widget.category.name}.png',
                height: 0.11 * height,
                width: 0.11 * height,
              ),
              SizedBox(width: 0.0),
            ],
          ),
          SizedBox(height: width / 7),
          unitInputContainer(),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: _topDesign(),
      ),
    );
  }
}
