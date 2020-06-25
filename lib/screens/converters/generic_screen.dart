import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../components/converter_numpad.dart';
import '../../providers/converter_provider.dart';
import '../units_screen.dart';

class UnitConverter extends StatelessWidget {
  const UnitConverter({Key key, this.categoryName}) : super(key: key);

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    final convProvider = Provider.of<ConverterProvider>(context);

    AppBar _buildAppBar() => AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          title: Text(
            categoryName,
            style: const TextStyle(
                letterSpacing: 1.5,
                color: Colors.white70,
                fontWeight: FontWeight.w600),
          ),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white70,
            ),
            onPressed: Get.back,
          ),
        );

    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(children: [
            const TopBackground(),
            TopSection(convProvider: convProvider),
          ]),
          const RepaintBoundary(child: ConverterKeypad()),
        ],
      ),
    );
  }
}

class TopSection extends StatelessWidget {
  const TopSection({
    Key key,
    @required this.convProvider,
  }) : super(key: key);

  final ConverterProvider convProvider;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Consumer<ConverterProvider>(
                builder: (_, conv, __) => ConverterSelection(
                    convProvider: conv,
                    whichUnit: 'from',
                    currentUnit: conv.fromUnit.name.toLowerCase()),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: InkWell(
                  onTap: () {
                    final tempTo = convProvider.toUnit.name;
                    convProvider
                      ..updateToUnit(convProvider.fromUnit.name)
                      ..updateFromUnit(tempTo);
                  },
                  child: const Icon(
                    AntDesign.swap,
                    color: Colors.white60,
                    size: 28,
                  ),
                ),
              ),
              Consumer<ConverterProvider>(
                builder: (_, conv, __) => ConverterSelection(
                    convProvider: conv,
                    whichUnit: 'to',
                    currentUnit: conv.toUnit.name.toLowerCase()),
              )
            ],
          ),
          const ConversionCard()
        ],
      );
}

class ConversionCard extends StatelessWidget {
  const ConversionCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding:
            EdgeInsets.symmetric(vertical: Get.height * 0.035, horizontal: 16),
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 3,
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'amount',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                            letterSpacing: 1),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Consumer<ConverterProvider>(
                      builder: (_, conv, __) => TextField(
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14),
                        enabled: true,
                        autofocus: true,
                        readOnly: true,
                        showCursor: true,
                        controller: conv.amountController,
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                          isDense: true,
                          suffixText: conv.fromUnit.symbol,
                          suffixStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 1.5,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'converted to',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                            letterSpacing: 1),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Consumer<ConverterProvider>(
                      builder: (_, conv, __) => InputDecorator(
                        decoration: InputDecoration(
                          isDense: true,
                          suffixText: conv.toUnit.symbol,
                          suffixStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 1.5,
                            ),
                          ),
                        ),
                        child: Text(
                          conv.convertedValue,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      );
}

class TopBackground extends StatelessWidget {
  const TopBackground({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        height: 0.25 * Get.height,
        color: Theme.of(context).primaryColor,
      );
}

class ConverterSelection extends StatelessWidget {
  const ConverterSelection({
    Key key,
    @required this.convProvider,
    @required this.whichUnit,
    @required this.currentUnit,
  }) : super(key: key);

  final ConverterProvider convProvider;
  final String currentUnit;
  final String whichUnit;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => Get.to(UnitsScreen(
          converterProvider: convProvider,
          whichUnit: whichUnit,
          currentUnit: currentUnit,
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              whichUnit,
              style: const TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 0.01 * Get.height),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.white12,
              ),
              height: 0.05 * Get.height,
              width: 0.41 * Get.width,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      currentUnit,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.w400),
                    ),
                  )),
            )
          ],
        ),
      );
}
