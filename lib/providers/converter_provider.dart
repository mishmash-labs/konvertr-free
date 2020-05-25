import 'package:flutter/material.dart';

import '../models/unit.dart';

class ConverterProvider extends ChangeNotifier {
  ConverterProvider(this.units) {
    setDefaults();
  }

  final List<Unit> units;

  String _convertedValue = '';
  Unit _fromUnit;
  double _inputValue;
  String _inputValueString;
  Unit _toUnit;

  String get convertedValue => _convertedValue;

  Unit get fromUnit => _fromUnit;

  Unit get toUnit => _toUnit;

  String get inputValueString => _inputValueString;

  String _format(double value) {
    var _outputVal = value.toStringAsPrecision(12);
    if (_outputVal.contains('.') && _outputVal.endsWith('0')) {
      var i = _outputVal.length - 1;
      while (_outputVal[i] == '0') {
        i -= 1;
      }
      _outputVal = _outputVal.substring(0, i + 1);
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

  /// Creates the dropdowns of the Unit converter
  // void createDropdownItems() {
  //   var newItems = <DropdownMenuItem>[];
  //   for (var unit in units) {
  //     newItems.add(DropdownMenuItem(
  //       value: unit.name,
  //       child: Container(
  //         child: Text(
  //           unit.name,
  //           softWrap: true,
  //         ),
  //       ),
  //     ));
  //   }
  //   _dropdownItems = newItems;
  // }

  /// Updates the conversion and returns the converted value
  Future<void> _updateConversion() async {
    _convertedValue =
        _format(_inputValue * (_toUnit.conversion / _fromUnit.conversion));
    notifyListeners();
  }

  updateInputString(String value) {
    if (value != "." && value != "0" && value != "00")
      _inputValueString = value;
    _updateInputVal();
  }

  /// Updates the input value and checks whether the input is in correct format or not
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

  /// Used as a getter method to get the required unit from the list of the given units
  Unit _getUnit(dynamic unitName) {
    return units.firstWhere(
      (Unit unit) {
        return unit.name == unitName;
      },
      orElse: null,
    );
  }

  void updateFromUnit(dynamic unitName) {
    _fromUnit = _getUnit(unitName);
    notifyListeners();
    if (_inputValue != null) {
      _updateConversion();
    }
  }

  void updateToUnit(dynamic unitName) {
    _toUnit = _getUnit(unitName);
    notifyListeners();
    if (_inputValue != null) {
      _updateConversion();
    }
  }
}
