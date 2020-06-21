import 'package:flutter/material.dart';

import '../models/unit.dart';

class ConverterProvider extends ChangeNotifier {
  ConverterProvider(
    this.units,
    this._categoryName,
    String fromUnit,
    String toUnit,
  ) {
    if (fromUnit == null)
      setDefaults();
    else {
      updateFromUnit(fromUnit);
      updateToUnit(toUnit);
    }
  }

  final List<Unit> units;

  String _categoryName;
  String _convertedValue = '';
  Unit _fromUnit;
  double _inputValue;
  String _inputValueString;
  Unit _toUnit;

  String get convertedValue => _convertedValue;

  Unit get fromUnit => _fromUnit;

  Unit get toUnit => _toUnit;

  String get inputValueString => _inputValueString;

  double get inputValue => _inputValue;

  String get categoryName => _categoryName;

  String _format(double value) {
    var _tempVal = value.toStringAsFixed(10);
    var _outputVal = double.parse(_tempVal).toStringAsPrecision(10);
    if (_outputVal.contains('.') && _outputVal.endsWith('0')) {
      _outputVal = _outputVal.replaceAll(RegExp(r'0*$'), '');
    }
    if (_outputVal.endsWith('.')) {
      _outputVal = _outputVal.substring(0, _outputVal.length - 1);
    }
    return _outputVal;
  }

  void setDefaults() {
    _fromUnit = units[0];
    _toUnit = units[1];
    if (_inputValue != null) {
      _updateConversion();
    }
  }

  Future<void> _updateConversion() async {
    if (_categoryName == "Temperature") {
      double temp = _toKelvin();
      _convertedValue = _format(_toTemperature(temp));
    } else {
      _convertedValue =
          _format(_inputValue * (_toUnit.conversion / _fromUnit.conversion));
    }
    notifyListeners();
  }

  double _toKelvin() {
    switch (fromUnit.name) {
      case "Celsius":
        return _inputValue + 273.15;
      case "Fahrenheit":
        return (_inputValue - 32) * 5 / 9 + 273.15;
      default:
        return _inputValue;
    }
  }

  double _toTemperature(double value) {
    switch (toUnit.name) {
      case "Celsius":
        return value - 273.15;
      case "Fahrenheit":
        return (value - 273.15) * 9 / 5 + 32;
      default:
        return value;
    }
  }

  updateInputString(String value) {
    if (value != ".") _inputValueString = value;
    _updateInputVal();
  }

  void _updateInputVal() {
    if (_inputValueString == null || _inputValueString.isEmpty) {
      _inputValue = null;
      _convertedValue = '';
      notifyListeners();
    } else {
      try {
        final double _inputDouble = double.parse(_inputValueString);
        _inputValue = _inputDouble;
        _updateConversion();
      } catch (e) {
        print(e);
      }
    }
  }

  Unit _getUnit(String unitName) {
    return units.firstWhere(
      (Unit unit) {
        return unit.name.toLowerCase() == unitName.toLowerCase();
      },
    );
  }

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
