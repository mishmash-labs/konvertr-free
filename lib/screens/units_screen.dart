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
  @override
  Widget build(BuildContext context) {
    final sortedUnits = widget.converterProvider.units
      ..sort((a, b) => a.name.compareTo(b.name));

    Widget _getListItem(Unit unit) => InkWell(
          onTap: () {
            widget.whichUnit == 'from'
                ? widget.converterProvider.updateFromUnit(unit.name)
                : widget.converterProvider.updateToUnit(unit.name);
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Text.rich(
              TextSpan(text: unit.name.toLowerCase(), children: [
                if (unit.symbol != '')
                  TextSpan(
                    text: '  ${unit.symbol}',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white24),
                  )
              ]),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color:
                    unit.name.toLowerCase() == widget.currentUnit.toLowerCase()
                        ? Colors.red
                        : Colors.white70,
              ),
            ),
          ),
        );

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white70),
          onPressed: Get.back,
        ),
      ),
      body: ListView.builder(
        itemCount: sortedUnits.length,
        itemBuilder: (context, index) => _getListItem(sortedUnits[index]),
      ),
    );
  }
}
