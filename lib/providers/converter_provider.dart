import 'package:flutter/material.dart';

import '../models/unit.dart';

class ConverterProvider extends ChangeNotifier {
  ConverterProvider(
      this.units, this._categoryName, String fromUnit, String toUnit) {
    _amountController = TextEditingController();
    if (fromUnit == null) {
      setDefaults();
    } else {
      updateFromUnit(fromUnit);
      updateToUnit(toUnit);
    }
  }

  int decimalPoints;
  int precision;
  final List<Unit> units;

  TextEditingController _amountController;
  final String _categoryName;
  String _convertedValue = '';
  Unit _fromUnit;
  double _inputValue;
  String _inputValueString;
  Unit _toUnit;

  String get convertedValue => _convertedValue;

  Unit get fromUnit => _fromUnit;

  Unit get toUnit => _toUnit;

  String get inputValueString => _inputValueString;

  TextEditingController get amountController => _amountController;

  double get inputValue => _inputValue;

  String get categoryName => _categoryName;

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
    final finalOutput = _thousandsFormatter(_outputVal);
    return finalOutput;
  }

  void setDefaults() {
    _fromUnit = units[0];
    _toUnit = units[1];
    if (_inputValue != null) {
      _updateConversion();
    }
  }

  Future<void> _updateConversion() async {
    if (_categoryName == 'temperature') {
      final temp = _toKelvin();
      _convertedValue = _format(_toTemperature(temp));
    } else {
      _convertedValue =
          _format(_inputValue * (_toUnit.conversion / _fromUnit.conversion));
    }
    notifyListeners();
  }

  double _toKelvin() {
    switch (fromUnit.name.toLowerCase()) {
      case 'celsius':
        return _inputValue + 273.15;
      case 'fahrenheit':
        return (_inputValue - 32) * 5 / 9 + 273.15;
      default:
        return _inputValue;
    }
  }

  double _toTemperature(double value) {
    switch (toUnit.name.toLowerCase()) {
      case 'celsius':
        return value - 273.15;
      case 'fahrenheit':
        return (value - 273.15) * 9 / 5 + 32;
      default:
        return value;
    }
  }

  void updateInputString(String value) {
    if (value != '.') {
      _inputValueString = value;
      final formattedValue = _thousandsFormatter(value);
      _amountController
        ..text = formattedValue
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
      final _inputDouble = double.parse(_inputValueString);
      _inputValue = _inputDouble;
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
}

String _thousandsFormatter(String value) {
  final regExp = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  final output = value.replaceAllMapped(regExp, (match) {
    final matchValue = value.substring(match.start, match.end);
    return '$matchValue,';
  });

  final regExp2 = RegExp(r'\.(\d{1,3},)+(\d+)?');
  final last = output.replaceAllMapped(regExp2, (match) {
    final value = output.substring(match.start, match.end);
    return value.replaceAll(',', '');
  });
  return last;
}
