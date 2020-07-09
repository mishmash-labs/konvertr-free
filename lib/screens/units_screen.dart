import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/unit.dart';
import '../providers/converter_provider.dart';

class UnitsScreen extends StatelessWidget {
  const UnitsScreen({key, this.convProvider, this.whichUnit, this.currentUnit})
      : super(key: key);

  final ConverterProvider convProvider;
  final String currentUnit;
  final String whichUnit;

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white70),
        onPressed: () => Navigator.pop(context),
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: appBar,
      body: ListView.builder(
        itemCount: convProvider.units.length,
        itemBuilder: (context, index) => UnitListItem(
          unit: convProvider.units[index],
          convProvider: convProvider,
          whichUnit: whichUnit,
          currentUnit: currentUnit,
        ),
      ),
    );
  }
}

class UnitListItem extends StatelessWidget {
  const UnitListItem(
      {key, this.convProvider, this.currentUnit, this.whichUnit, this.unit})
      : super(key: key);

  final ConverterProvider convProvider;
  final String currentUnit;
  final String whichUnit;
  final Unit unit;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          whichUnit == 'from'
              ? convProvider.updateFromUnit(unit.name)
              : convProvider.updateToUnit(unit.name);
          Navigator.pop(context);
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
              color: unit.name.toLowerCase() == currentUnit.toLowerCase()
                  ? Colors.red
                  : Colors.white60,
            ),
          ),
        ),
      );
}
