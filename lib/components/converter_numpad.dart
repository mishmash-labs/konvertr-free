import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clipboard_manager/flutter_clipboard_manager.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import '../providers/converter_provider.dart';
import '../utils/theme.dart';

class ConverterKeypad extends StatefulWidget {
  const ConverterKeypad({Key key}) : super(key: key);

  @override
  _ConverterKeypadState createState() => _ConverterKeypadState();
}

class _ConverterKeypadState extends State<ConverterKeypad> {
  @override
  Widget build(BuildContext context) {
    final converterProvider =
        Provider.of<ConverterProvider>(context, listen: false);
    const buttonHeight = 0.09375;

    Widget keypadButton({String value}) => InkWell(
          onTap: () {
            if (value == '.' && converterProvider.inputValueString == null ||
                value == '.' && converterProvider.inputValueString == '') {
              converterProvider.updateInputString('0.');
            } else if (value == '.' &&
                converterProvider.inputValueString != null) {
              if (!converterProvider.inputValueString.endsWith('.') &&
                  converterProvider.inputValueString.isNotEmpty) {
                converterProvider.updateInputString(
                    converterProvider.inputValueString + value);
              }
            } else {
              if (converterProvider.inputValueString == null) {
                converterProvider.updateInputString(value);
              } else {
                final temp = converterProvider.inputValueString + value;
                converterProvider.updateInputString(temp);
              }
            }
          },
          child: SizedBox(
            height: buttonHeight * MediaQuery.of(context).size.height,
            child: Center(
              child: Text(
                value,
                style: const TextStyle(color: Colors.white60, fontSize: 32),
              ),
            ),
          ),
        );

    Widget eraseButton() => InkWell(
          onTap: () {
            final temp = converterProvider.inputValueString
                .substring(0, converterProvider.inputValueString.length - 1);
            converterProvider.updateInputString(temp);
          },
          child: SizedBox(
            height: buttonHeight * MediaQuery.of(context).size.height,
            child: const Center(
                child: Icon(MaterialCommunityIcons.backspace_outline,
                    color: Colors.white60, size: 32)),
          ),
        );

    Widget copyButton() => InkWell(
          onTap: () {
            if (converterProvider.convertedValue != '') {
              FlutterClipboardManager.copyToClipBoard(
                      '${converterProvider.inputValueString} ${converterProvider.fromUnit.symbol} = '
                      '${converterProvider.convertedValue} ${converterProvider.toUnit.symbol}')
                  .then((result) {
                if (result) {
                  Flushbar(
                    margin: const EdgeInsets.all(8),
                    borderRadius: 8,
                    flushbarPosition: FlushbarPosition.TOP,
                    message: 'conversion copied to clipboard',
                    icon: const Icon(
                      Feather.copy,
                      color: Colors.white60,
                    ),
                    backgroundColor: secondaryColor.withOpacity(0.5),
                    barBlur: 8,
                    shouldIconPulse: true,
                    duration: const Duration(seconds: 3),
                  ).show(context);
                }
              });
            }
          },
          child: SizedBox(
            height: buttonHeight * MediaQuery.of(context).size.height,
            child: const Center(
                child: Icon(Feather.copy, color: Colors.white60, size: 32)),
          ),
        );

    Widget swapButton() => InkWell(
          onTap: () {
            final tempTo = converterProvider.toUnit.name;
            converterProvider
              ..updateToUnit(converterProvider.fromUnit.name)
              ..updateFromUnit(tempTo);
          },
          child: SizedBox(
            height: buttonHeight * MediaQuery.of(context).size.height,
            child: const Center(
                child: Icon(AntDesign.swap, color: Colors.white60, size: 32)),
          ),
        );

    Widget changeSymbolButton() => InkWell(
          onTap: () {
            if (converterProvider.inputValue != null) {
              if (converterProvider.inputValue.isNegative) {
                converterProvider.updateInputString(converterProvider
                    .inputValueString
                    .substring(1, converterProvider.inputValueString.length));
              } else {
                converterProvider.updateInputString(
                    '-${converterProvider.inputValueString}');
              }
            }
          },
          child: SizedBox(
            height: buttonHeight * MediaQuery.of(context).size.height,
            child: const Center(
              child: Text(
                '+/-',
                style: TextStyle(color: Colors.white60, fontSize: 32),
              ),
            ),
          ),
        );

    Widget clearButton() => InkWell(
          onTap: () => converterProvider.updateInputString(''),
          child: SizedBox(
              height: buttonHeight * MediaQuery.of(context).size.height,
              child: const Center(
                child: Text(
                  'C',
                  style: TextStyle(color: Colors.white60, fontSize: 32),
                ),
              )),
        );

    return Container(
        color: Theme.of(context).primaryColor,
        child: Table(
          children: [
            TableRow(
              children: <Widget>[
                keypadButton(value: '7'),
                keypadButton(value: '8'),
                keypadButton(value: '9'),
                copyButton(),
              ],
            ),
            TableRow(
              children: <Widget>[
                keypadButton(value: '4'),
                keypadButton(value: '5'),
                keypadButton(value: '6'),
                swapButton(),
              ],
            ),
            TableRow(
              children: <Widget>[
                keypadButton(value: '1'),
                keypadButton(value: '2'),
                keypadButton(value: '3'),
                clearButton(),
              ],
            ),
            TableRow(
              children: <Widget>[
                keypadButton(value: '.'),
                keypadButton(value: '0'),
                converterProvider.categoryName == 'temperature'
                    ? changeSymbolButton()
                    : keypadButton(value: '00'),
                eraseButton(),
              ],
            ),
          ],
        ));
  }
}
