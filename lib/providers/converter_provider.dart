import 'package:flutter/material.dart';
import 'package:konvertr/models/unit.dart';

String _format(double value) {
  var _outputVal = value.toStringAsPrecision(8);
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

String _convertedValue = '';
List<DropdownMenuItem> _dropdownItems;
Unit _fromUnit;
double _inputValue;
Unit _toUnit;
List<Unit> _units;

void _setDefaults() {
  _fromUnit = _units[0];
  _toUnit = _units[1];
  if (_inputValue != null) {
    _updateConversion();
  }
}

/// Creates the dropdowns of the Unit converter
void _createDropdownItems() {
  var newItems = <DropdownMenuItem>[];
  for (var unit in _units) {
    newItems.add(DropdownMenuItem(
      value: unit.name,
      child: Container(
        child: Text(
          unit.name,
          softWrap: true,
        ),
      ),
    ));
  }
  _dropdownItems = newItems;
}

/// Updates the conversion and returns the converted value
Future<void> _updateConversion() async {
  _convertedValue =
      _format(_inputValue * (_toUnit.conversion / _fromUnit.conversion));
}

/// Updates the input value and checks whether the input is in correct format or not
void _updateInputVal(String value) {
  if (value == null || value.isEmpty) {
    _convertedValue = '';
  } else {
    try {
      final _inputDouble = double.parse(value);
      _inputValue = _inputDouble;
      _updateConversion();
    } catch (e) {
      print(e);
    }
  }
}

/// Used as a getter method to get the required unit from the list of the given units
Unit _getUnit(dynamic unitName) {
  return _units.firstWhere(
    (Unit unit) {
      return unit.name == unitName;
    },
    orElse: null,
  );
}

/// Updates the [_fromUnit]
void _updateFromUnit(dynamic unitName) {
  _fromUnit = _getUnit(unitName);
  if (_inputValue != null) {
    _updateConversion();
  }
}

/// Updates the [_toUnit]
void _updateToUnit(dynamic unitName) {
  _toUnit = _getUnit(unitName);
  if (_inputValue != null) {
    _updateConversion();
  }
}
