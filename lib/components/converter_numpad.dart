import 'package:flutter/material.dart';
import 'package:flutter_clipboard_manager/flutter_clipboard_manager.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../providers/converter_provider.dart';

class ConverterKeypad extends StatefulWidget {
  @override
  _ConverterKeypadState createState() => _ConverterKeypadState();
}

class _ConverterKeypadState extends State<ConverterKeypad> {
  @override
  Widget build(BuildContext context) {
    ConverterProvider converterProvider = context.watch<ConverterProvider>();
    double buttonHeight = 0.09375;

    Widget keypadButton({String value}) {
      return Expanded(
        child: InkWell(
          onTap: () {
            if (value == "." && converterProvider.inputValueString != null) {
              if (!converterProvider.inputValueString.endsWith(".") &&
                  converterProvider.inputValueString.isNotEmpty) {
                converterProvider.updateInputString(
                    converterProvider.inputValueString + value);
              }
            } else {
              if (converterProvider.inputValueString == null) {
                converterProvider.updateInputString(value);
              } else {
                String temp = converterProvider.inputValueString + value;
                converterProvider.updateInputString(temp);
              }
            }
          },
          child: SizedBox(
            height: buttonHeight * Get.height,
            child: Center(
              child: Text(
                value,
                style: TextStyle(color: Colors.white70, fontSize: 32),
              ),
            ),
          ),
        ),
      );
    }

    Widget eraseButton() {
      return Expanded(
        child: InkWell(
          onTap: () {
            String temp = converterProvider.inputValueString
                .substring(0, converterProvider.inputValueString.length - 1);
            converterProvider.updateInputString(temp);
          },
          child: SizedBox(
            height: buttonHeight * Get.height,
            child: Center(
                child: Icon(Icons.backspace, color: Colors.white70, size: 32)),
          ),
        ),
      );
    }

    Widget copyButton() {
      return Expanded(
        child: InkWell(
          onTap: () {
            if (converterProvider.convertedValue != "") {
              FlutterClipboardManager.copyToClipBoard(
                      "${converterProvider.inputValueString} ${converterProvider.fromUnit.symbol} = ${converterProvider.convertedValue} ${converterProvider.toUnit.symbol}")
                  .then((result) {
                if (result) {
                  Get.snackbar(
                    "Clipboard Updated",
                    "Conversion copied to clipboard.",
                    colorText: Colors.white70,
                    icon: Icon(
                      Icons.content_copy,
                      color: Colors.white70,
                    ),
                  );
                }
              });
            }
          },
          child: SizedBox(
            height: buttonHeight * Get.height,
            child: Center(
                child:
                    Icon(Icons.content_copy, color: Colors.white70, size: 32)),
          ),
        ),
      );
    }

    Widget swapButton() {
      return Expanded(
        child: InkWell(
          onTap: () {
            String tempTo = converterProvider.toUnit.name;
            converterProvider.updateToUnit(converterProvider.fromUnit.name);
            converterProvider.updateFromUnit(tempTo);
          },
          child: SizedBox(
            height: buttonHeight * Get.height,
            child: Center(
                child: Icon(Icons.swap_horiz, color: Colors.white70, size: 32)),
          ),
        ),
      );
    }

    Widget changeSymbolButton() {
      return Expanded(
        child: InkWell(
          onTap: () {
            if (converterProvider.inputValue != null) {
              if (converterProvider.inputValue.isNegative) {
                converterProvider.updateInputString(converterProvider
                    .inputValueString
                    .substring(1, converterProvider.inputValueString.length));
              } else {
                converterProvider.updateInputString(
                    "-" + converterProvider.inputValueString);
              }
            }
          },
          child: SizedBox(
            height: buttonHeight * Get.height,
            child: Center(
              child: Text(
                "+/-",
                style: TextStyle(color: Colors.white70, fontSize: 32),
              ),
            ),
          ),
        ),
      );
    }

    Widget clearButton() {
      return Expanded(
        child: InkWell(
          onTap: () {
            converterProvider.updateInputString("");
          },
          child: SizedBox(
              height: buttonHeight * Get.height,
              child: Center(
                child: Text(
                  "C",
                  style: TextStyle(color: Colors.white70, fontSize: 32),
                ),
              )),
        ),
      );
    }

    return Container(
        color: Theme.of(context).primaryColor,
        height: 0.375 * Get.height,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                keypadButton(value: '7'),
                keypadButton(value: '8'),
                keypadButton(value: '9'),
                copyButton(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                keypadButton(value: '4'),
                keypadButton(value: '5'),
                keypadButton(value: '6'),
                swapButton(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                keypadButton(value: '1'),
                keypadButton(value: '2'),
                keypadButton(value: '3'),
                clearButton(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                keypadButton(value: '.'),
                keypadButton(value: '0'),
                converterProvider.categoryName == "Temperature"
                    ? changeSymbolButton()
                    : keypadButton(value: '00'),
                eraseButton(),
              ],
            ),
          ],
        ));
  }
}
