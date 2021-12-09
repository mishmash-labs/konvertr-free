import 'package:flutter/material.dart';
import 'package:flutter_scroll_to_top/flutter_scroll_to_top.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../components/my_appbar.dart';
import '../models/unit.dart';
import '../providers/converter_provider.dart';

class UnitsScreen extends StatelessWidget {
  UnitsScreen({key, this.convProvider, this.whichUnit, this.currentUnit})
      : super(key: key);

  final ConverterProvider convProvider;
  final String currentUnit;
  final String whichUnit;
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: CustomAppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white70),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ScrollWrapper(
          scrollController: scrollController,
          promptAlignment: Alignment.bottomRight,
          promptAnimationCurve: Curves.elasticInOut,
          promptDuration: const Duration(milliseconds: 400),
          enabledAtOffset: 100,
          promptTheme: PromptButtonTheme(
              icon: const Icon(Icons.keyboard_arrow_up, color: Colors.white54),
              color: HSLColor.fromColor(const Color(0xff380e7f))
                  .withLightness(0.2)
                  .toColor()),
          builder: (ctx, props) {
            return ListView.builder(
              controller: scrollController,
              itemCount: convProvider.units.length,
              itemBuilder: (context, index) => _UnitListItem(
                unit: convProvider.units[index],
                convProvider: convProvider,
                whichUnit: whichUnit,
                currentUnit: currentUnit,
              ),
            );
          }),
    );
  }
}

class _UnitListItem extends StatelessWidget {
  const _UnitListItem(
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
            TextSpan(text: translate(unit.name).toLowerCase(), children: [
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
