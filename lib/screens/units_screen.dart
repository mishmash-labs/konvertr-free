import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:konvertr/models/unit.dart';
import 'package:konvertr/providers/converter_provider.dart';
import 'package:konvertr/utils/theme.dart';
import 'package:provider/provider.dart';

class UnitsScreen extends StatefulWidget {
  final ConverterProvider converterProvider;
  final String whichUnit;
  final String currentUnit;
  const UnitsScreen(
      {Key key, this.converterProvider, this.whichUnit, this.currentUnit})
      : super(key: key);
  @override
  _UnitsScreenState createState() => _UnitsScreenState();
}

class _UnitsScreenState extends State<UnitsScreen> {
  var color;
  @override
  Widget build(BuildContext context) {
    Widget getListItem(Unit unit) {
      if (unit.name == widget.currentUnit)
        color = Colors.red;
      else
        color = Colors.white70;
      return InkWell(
        onTap: () {
          if (widget.whichUnit == "From")
            widget.converterProvider.updateFromUnit(unit.name);
          else
            widget.converterProvider.updateToUnit(unit.name);

          Navigator.of(context).pop();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
          child: Text(
            unit.name,
            style: GoogleFonts.roboto(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      );
    }

    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white70),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: ListView.builder(
            itemCount: widget.converterProvider.units.length,
            itemBuilder: (BuildContext context, int index) {
              return getListItem(widget.converterProvider.units[index]);
            }));
  }
}
