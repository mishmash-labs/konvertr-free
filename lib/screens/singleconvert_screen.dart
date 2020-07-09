import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:konvertr_free/utils/theme.dart';
import 'package:provider/provider.dart';

import '../components/converter_numpad.dart';
import '../providers/converter_provider.dart';
import 'units_screen.dart';

class SingleConverter extends StatelessWidget {
  const SingleConverter({key, this.categoryName}) : super(key: key);

  final String categoryName;

  @override
  Widget build(BuildContext context) {
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
              onPressed: () => Navigator.pop(context)),
        );

    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: secondaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(children: [
            const TopBackground(),
            const TopSection(),
          ]),
          const RepaintBoundary(child: ConverterKeypad()),
        ],
      ),
    );
  }
}

class TopSection extends StatelessWidget {
  const TopSection({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final convProvider = Provider.of<ConverterProvider>(context);

    return Column(
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
                onTap: () => convProvider.executeButton(context, 'swap'),
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
}

class ConversionCard extends StatelessWidget {
  const ConversionCard({key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.035,
            horizontal: 16),
        child: Card(
            color: secondaryColor,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 2, color: Colors.white10),
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'amount',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white54,
                            letterSpacing: 1),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Consumer<ConverterProvider>(
                      builder: (_, conv, __) => TextField(
                        style: const TextStyle(
                            color: Colors.white54, fontSize: 14),
                        enabled: true,
                        autofocus: true,
                        readOnly: true,
                        showCursor: true,
                        controller: conv.amountController,
                        cursorColor: Colors.white54,
                        decoration: InputDecoration(
                          isDense: true,
                          suffixText: conv.fromUnit.symbol,
                          suffixStyle: const TextStyle(color: Colors.white54),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white54,
                              width: 1.5,
                            ),
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white54,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'converted to',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white54,
                            letterSpacing: 1),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Consumer<ConverterProvider>(
                      builder: (_, conv, __) => InputDecorator(
                        decoration: InputDecoration(
                          isDense: true,
                          suffixText: conv.toUnit.symbol,
                          suffixStyle: const TextStyle(color: Colors.white54),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white54,
                              width: 1.5,
                            ),
                          ),
                        ),
                        child: Text(
                          conv.convertedValue,
                          style: const TextStyle(
                              color: Colors.white54, fontSize: 14),
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
  const TopBackground({key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))),
        height: 0.25 * MediaQuery.of(context).size.height,
      );
}

class ConverterSelection extends StatelessWidget {
  const ConverterSelection({
    key,
    @required this.convProvider,
    @required this.whichUnit,
    @required this.currentUnit,
  }) : super(key: key);

  final ConverterProvider convProvider;
  final String currentUnit;
  final String whichUnit;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UnitsScreen(
                convProvider: convProvider,
                whichUnit: whichUnit,
                currentUnit: currentUnit,
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              whichUnit,
              style: const TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 0.01 * MediaQuery.of(context).size.height),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: secondaryColor,
              ),
              height: 0.05 * MediaQuery.of(context).size.height,
              width: 0.41 * MediaQuery.of(context).size.width,
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
                ),
              ),
            )
          ],
        ),
      );
}
