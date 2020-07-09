import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clipboard_manager/flutter_clipboard_manager.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:konvertr_free/utils/theme.dart';

import '../models/unit.dart';

class ConverterProvider extends ChangeNotifier {
  ConverterProvider(
      this._units, this._categoryName, String fromUnit, String toUnit) {
    _amountController = TextEditingController();
    if (fromUnit == null) {
      setDefaults();
    } else {
      updateFromUnit(fromUnit);
      updateToUnit(toUnit);
    }
  }

  TextEditingController _amountController;
  final String _categoryName;
  String _convertedValue = '';
  Unit _fromUnit;
  double _inputValue;
  String _inputValueString;
  Unit _toUnit;
  final List<Unit> _units;

  String get convertedValue => _convertedValue;

  Unit get fromUnit => _fromUnit;

  Unit get toUnit => _toUnit;

  TextEditingController get amountController => _amountController;

  String get categoryName => _categoryName;

  List<Unit> get units => _units;

  String _format(double value) {
    final _tempVal = value.toStringAsFixed(10);
    var _outputVal = double.parse(_tempVal).toStringAsPrecision(15);
    if (_outputVal.contains('.') &&
        _outputVal.endsWith('0') &&
        !_outputVal.contains('e')) {
      _outputVal = _outputVal.replaceAll(RegExp(r'0*$'), '');
    }
    if (_outputVal.endsWith('.')) {
      _outputVal = _outputVal.substring(0, _outputVal.length - 1);
    }
    return _thousandsFormatter(_outputVal);
  }

  void setDefaults() {
    _fromUnit = units[0];
    _toUnit = units[1];
    if (_inputValue != null) {
      _updateConversion();
    }
  }

  void executeButton(BuildContext context, String value) {
    switch (value) {
      case 'C':
        _updateInputString('');
        break;
      case 'del':
        _updateInputString(
            _inputValueString.substring(0, _inputValueString.length - 1));
        break;
      case 'swap':
        final tempTo = toUnit.name;
        updateToUnit(fromUnit.name);
        updateFromUnit(tempTo);
        break;
      case '+/-':
        if (_inputValue != null) {
          if (_inputValue.isNegative) {
            _updateInputString(
                _inputValueString.substring(1, _inputValueString.length));
          } else {
            _updateInputString('-$_inputValueString');
          }
        }
        break;
      case 'copy':
        if (convertedValue != '') {
          FlutterClipboardManager.copyToClipBoard(
                  '$_inputValueString ${fromUnit.name} = $convertedValue ${toUnit.name}')
              .then(
            (result) {
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
                  backgroundColor: secondaryColor,
                  barBlur: 8,
                  shouldIconPulse: true,
                  duration: const Duration(seconds: 3),
                ).show(context);
              }
            },
          );
        }
        break;
      case '.':
        if (_inputValueString == null || _inputValueString == '') {
          _updateInputString('0.');
        } else if (_inputValueString != null) {
          if (!_inputValueString.contains('.') &&
              _inputValueString.isNotEmpty) {
            _updateInputString(_inputValueString + value);
          }
        }
        break;
      case '00':
        if (_inputValueString == null || _inputValueString == '') {
        } else {
          _updateInputString(_inputValueString + value);
        }
        break;
      case '0':
        if (_inputValueString == null || _inputValueString == '') {
          _updateInputString('0.');
        } else {
          _updateInputString(_inputValueString + value);
        }

        break;
      default:
        _buttonValue(value);
    }
  }

  void _buttonValue(String value) {
    if (_inputValueString == null) {
      _updateInputString(value);
    } else {
      _updateInputString(_inputValueString + value);
    }
  }

  Future<void> _updateConversion() async {
    if (_categoryName == 'temperature') {
      _convertedValue = _format(_toTemperature());
    } else {
      _convertedValue =
          _format(_inputValue * (_toUnit.conversion / _fromUnit.conversion));
    }
    notifyListeners();
  }

  double _toTemperature() {
    double finalVal;
    switch (fromUnit.name.toLowerCase()) {
      case 'celsius':
        finalVal = _inputValue + 273.15;
        break;
      case 'fahrenheit':
        finalVal = (_inputValue - 32) * 5 / 9 + 273.15;
        break;
      default:
        finalVal = _inputValue;
    }

    switch (toUnit.name.toLowerCase()) {
      case 'celsius':
        return finalVal - 273.15;
      case 'fahrenheit':
        return (finalVal - 273.15) * 9 / 5 + 32;
      default:
        return finalVal;
    }
  }

  void _updateInputString(String value) {
    if (value != '.') {
      _inputValueString = value;
      _amountController
        ..text = _thousandsFormatter(value)
        ..selection = TextSelection.fromPosition(
            TextPosition(offset: _amountController.text.length));
    }
    _updateInputVal();
  }

  void _updateInputVal() {
    if (_inputValueString == null || _inputValueString.isEmpty) {
      _inputValue = null;
      _convertedValue = '';
      notifyListeners();
    } else {
      _inputValue = double.parse(_inputValueString);
      _updateConversion();
    }
  }

  Unit _getUnit(String unitName) => units.firstWhere(
        (unit) => unit.name.toLowerCase() == unitName.toLowerCase(),
      );

  void updateFromUnit(String unitName) {
    _fromUnit = _getUnit(unitName);
    notifyListeners();
    if (_inputValue != null) {
      _updateConversion();
    }
  }

  void updateToUnit(String unitName) {
    _toUnit = _getUnit(unitName);
    notifyListeners();
    if (_inputValue != null) {
      _updateConversion();
    }
  }

  String _thousandsFormatter(String value) {
    final output =
        value.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (match) {
      final matchValue = value.substring(match.start, match.end);
      return '$matchValue,';
    });

    return output.replaceAllMapped(RegExp(r'\.(\d{1,3},)+(\d+)?'), (match) {
      final value = output.substring(match.start, match.end);
      return value.replaceAll(',', '');
    });
  }
}
