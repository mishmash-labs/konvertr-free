import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';

import '../components/converter_numpad.dart';
import '../components/my_appbar.dart';
import '../providers/converter_provider.dart';
import '../utils/extensions.dart';
import '../utils/icons.dart';
import '../utils/keys.dart';
import '../utils/theme.dart';
import 'units_screen.dart';

class SingleConverter extends StatelessWidget {
  const SingleConverter({key, this.categoryName}) : super(key: key);

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: categoryName,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white70,
            ),
            onPressed: () => Navigator.pop(context)),
      ),
      backgroundColor: secondaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(children: [
            const _TopBackground(),
            const _TopSection(),
          ]),
          const RepaintBoundary(child: ConverterKeypad()),
        ],
      ),
    );
  }
}

class _TopSection extends StatelessWidget {
  const _TopSection({key}) : super(key: key);

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
                  KonvertrIcons.swap,
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
        const _ConversionCard()
      ],
    );
  }
}

class _ConversionCard extends StatelessWidget {
  const _ConversionCard({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.035, horizontal: 16),
      child: Card(
          color: secondaryColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 2, color: Colors.white10),
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      translate(Keys.Converter_Amount).toLowerCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white54,
                          letterSpacing: 1),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Consumer<ConverterProvider>(
                    builder: (_, conv, __) => TextField(
                      style: TextStyle(color: Colors.white54, fontSize: 14),
                      enabled: true,
                      autofocus: true,
                      readOnly: true,
                      showCursor: true,
                      controller: conv.amountController,
                      cursorColor: Colors.white54,
                      decoration: InputDecoration(
                        isDense: true,
                        suffixText: conv.fromUnit.symbol,
                        suffixStyle: TextStyle(color: Colors.white54),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white54,
                            width: 1.5,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white54,
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
                      translate(Keys.Converter_Converted_To).toLowerCase(),
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
                        suffixStyle: TextStyle(color: Colors.white54),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white54,
                            width: 1.5,
                          ),
                        ),
                      ),
                      child: Text(
                        conv.convertedValue,
                        style: TextStyle(color: Colors.white54, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class _TopBackground extends StatelessWidget {
  const _TopBackground({key}) : super(key: key);

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
          context.navigateTo(
            UnitsScreen(
              convProvider: convProvider,
              whichUnit: whichUnit,
              currentUnit: currentUnit,
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              translate(whichUnit).toLowerCase(),
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
                    translate(currentUnit).toLowerCase(),
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
