// import 'package:flutter/material.dart';

// import '../models/unit.dart';

// /// The Unitconverter main logic and some UI
// class UnitConFgUI extends StatefulWidget {
//   @override
//   _UnitConFgUIState createState() => _UnitConFgUIState();
// }

// class _UnitConFgUIState extends State<UnitConFgUI> {
//   @override
//   void didUpdateWidget(UnitConFgUI old) {
//     super.didUpdateWidget(old);
//     if (widget.units != old.units) {
//       _setDefaults();
//       _createDropdownItems();
//     }
//     if (_inputValue != null) {
//       _updateConversion();
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _setDefaults();
//     _createDropdownItems();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _height = MediaQuery.of(context).size.height;
//     final _fontSize = 0.02445997458703939087 * _height;

//     final _inputTextTheme = Theme.of(context).textTheme.headline5.copyWith(
//       fontSize: _fontSize,
//       fontWeight: FontWeight.w400,
//       color: Theme.of(context).hoverColor,
//       shadows: [],
//     );
//     final _borderRadius = BorderRadius.circular(10);
//     final _materialElevation = 2.0;
//     final _materialShadowColor = Theme.of(context).hintColor;
//     final _materialColor = Theme.of(context).primaryColor;
//     final _outlineBorder = OutlineInputBorder(
//       borderRadius: _borderRadius,
//       borderSide: BorderSide(
//         color: Theme.of(context).focusColor,
//         width: 1.3,
//         style: BorderStyle.solid,
//       ),
//     );

//     /// Reusable widget to build the dropdowns
//     Widget _buildUnitsDropdown(
//         String currentValue, ValueChanged<dynamic> onChanged) {
//       return Container(
//         padding: EdgeInsets.symmetric(vertical: 8.0),
//         decoration: BoxDecoration(
//           borderRadius: _borderRadius,
//           border: Border.all(
//             width: 1.4,
//             color: Theme.of(context).focusColor,
//           ),
//           // color: Theme.of(context).hintColor,
//         ),
//         child: DropdownButtonHideUnderline(
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: _borderRadius,
//             ),
//             child: ButtonTheme(
//               alignedDropdown: true,
//               child: DropdownButton(
//                 value: currentValue,
//                 items: _dropdownItems,
//                 onChanged: onChanged,
//                 style: _inputTextTheme.copyWith(
//                   fontSize: _fontSize,
//                   fontWeight: FontWeight.w400,
//                   shadows: [],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//     }

//     /// Builds the input part of the screen
//     Widget _buildInputContainer() {
//       return Container(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               Expanded(
//                 flex: 4,
//                 child: Material(
//                   elevation: _materialElevation,
//                   color: _materialColor,
//                   shadowColor: _materialShadowColor,
//                   borderRadius: _borderRadius,
//                   child: Container(
//                     child: TextField(
//                       key: _inputKey,
//                       decoration: InputDecoration(
//                         labelText: 'Input',
//                         labelStyle: _inputTextTheme,
//                         focusedBorder: _outlineBorder,
//                         enabledBorder: _outlineBorder,
//                         contentPadding:
//                             EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//                       ),
//                       cursorColor: Theme.of(context).focusColor,
//                       style: _inputTextTheme.copyWith(fontSize: _fontSize),
//                       keyboardType: TextInputType.number,
//                       onChanged: (newValue) {
//                         _updateInputVal(newValue);
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(flex: 2, child: SizedBox(height: 16.0)),
//               Expanded(
//                 flex: 4,
//                 child: Material(
//                     elevation: _materialElevation,
//                     shadowColor: _materialShadowColor,
//                     color: _materialColor,
//                     borderRadius: _borderRadius,
//                     child:
//                         _buildUnitsDropdown(_fromUnit.name, _updateFromUnit)),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     /// Builds the arrows
//     Widget _buildArrows() {
//       return Container(
//         child: RotatedBox(
//           quarterTurns: 1,
//           child: Icon(Icons.compare_arrows,
//               size: 45, color: Theme.of(context).splashColor),
//         ),
//       );
//     }

//     /// Builds the output part of the screen
//     Widget _buildOutputContainer() {
//       return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
//         child: Container(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Expanded(
//                 flex: 4,
//                 child: Material(
//                   elevation: _materialElevation,
//                   color: _materialColor,
//                   shadowColor: _materialShadowColor,
//                   borderRadius: _borderRadius,
//                   child: InputDecorator(
//                     child: Container(
//                       // height: 50,
//                       child: Text(
//                         _convertedValue,
//                         style: _inputTextTheme,
//                       ),
//                     ),
//                     decoration: InputDecoration(
//                       labelText: 'Output',
//                       labelStyle: _inputTextTheme,
//                       enabledBorder: _outlineBorder,
//                       contentPadding: EdgeInsets.fromLTRB(
//                           0.02223634053367217351 * _height, // 20
//                           0.05203176620076239041 * _height, // 45
//                           0.02223634053367217351 * _height, // 20
//                           0), //0.00555908513341804338 * _height), //  5
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(flex: 2, child: SizedBox(height: 15)),
//               Expanded(
//                 flex: 4,
//                 child: Material(
//                     elevation: _materialElevation,
//                     color: _materialColor,
//                     shadowColor: _materialShadowColor,
//                     borderRadius: _borderRadius,
//                     child: _buildUnitsDropdown(_toUnit.name, _updateToUnit)),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     /// Returns [ErrorUI] or [UnitConverter] based on the value of [_showValidationError]
//     Widget _buildScreen() {
//       return Column(
//         // mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Expanded(flex: 3, child: _buildInputContainer()),
//           Expanded(flex: 1, child: _buildArrows()),
//           Expanded(flex: 3, child: _buildOutputContainer()),
//         ],
//       );
//     }

//     /// Final return
//     return _buildScreen();
//   }
// }
