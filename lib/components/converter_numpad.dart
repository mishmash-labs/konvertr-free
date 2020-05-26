import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../providers/converter_provider.dart';
import '../utils/theme.dart';

class ConverterKeypad extends StatefulWidget {
  @override
  _ConverterKeypadState createState() => _ConverterKeypadState();
}

class _ConverterKeypadState extends State<ConverterKeypad> {
  @override
  Widget build(BuildContext context) {
    ConverterProvider converterProvider = context.watch<ConverterProvider>();

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
            height: 0.1 * Get.height,
            width: double.infinity,
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
            height: 0.1 * Get.height,
            width: double.infinity,
            child: Center(
                child: Icon(Icons.backspace, color: Colors.white70, size: 32)),
          ),
        ),
      );
    }

    Widget copyButton() {
      return Expanded(
        child: InkWell(
          onTap: () {},
          child: SizedBox(
            height: 0.1 * Get.height,
            width: double.infinity,
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
            height: 0.1 * Get.height,
            width: double.infinity,
            child: Center(
                child: Icon(Icons.swap_calls, color: Colors.white70, size: 32)),
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
              height: 0.1 * Get.height,
              width: double.infinity,
              child: Center(
                child: Text(
                  "AC",
                  style: TextStyle(color: Colors.white70, fontSize: 32),
                ),
              )),
        ),
      );
    }

    return Container(
        color: primaryColor,
        height: 0.41 * Get.height,
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  keypadButton(value: '7'),
                  keypadButton(value: '8'),
                  keypadButton(value: '9'),
                  copyButton(),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  keypadButton(value: '4'),
                  keypadButton(value: '5'),
                  keypadButton(value: '6'),
                  swapButton(),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  keypadButton(value: '1'),
                  keypadButton(value: '2'),
                  keypadButton(value: '3'),
                  clearButton(),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  keypadButton(value: '.'),
                  keypadButton(value: '0'),
                  keypadButton(value: '00'),
                  eraseButton(),
                ],
              ),
            ),
          ],
        ));
  }
}
