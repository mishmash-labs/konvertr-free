import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/unit.dart';
import '../providers/converter_provider.dart';

class UnitsScreen extends StatefulWidget {
  const UnitsScreen(
      {Key key, this.converterProvider, this.whichUnit, this.currentUnit})
      : super(key: key);

  final ConverterProvider converterProvider;
  final String currentUnit;
  final String whichUnit;

  @override
  _UnitsScreenState createState() => _UnitsScreenState();
}

class _UnitsScreenState extends State<UnitsScreen> {
  var color;

  @override
  Widget build(BuildContext context) {
    List<Unit> sortedUnits = widget.converterProvider.units
      ..sort((a, b) => a.name.compareTo(b.name));

    Widget getListItem(Unit unit) {
      if (unit.name.toLowerCase() == widget.currentUnit.toLowerCase())
        color = Colors.red;
      else
        color = Colors.white70;
      return InkWell(
        onTap: () {
          if (widget.whichUnit == "from")
            widget.converterProvider.updateFromUnit(unit.name);
          else
            widget.converterProvider.updateToUnit(unit.name);
          Get.back();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
          child: Text.rich(
            TextSpan(text: unit.name.toLowerCase(), children: [
              if (unit.symbol != "")
                TextSpan(
                  text: "  " + unit.symbol,
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white24),
                )
            ]),
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      );
    }

    return Scaffold(
        backgroundColor: Get.theme.primaryColor,
        appBar: AppBar(
          backgroundColor: Get.theme.primaryColor,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white70),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: ListView.builder(
            itemCount: sortedUnits.length,
            itemBuilder: (BuildContext context, int index) {
              return getListItem(sortedUnits[index]);
            }));
  }
}
