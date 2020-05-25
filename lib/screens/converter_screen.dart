import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:konvertr/models/category.dart';
import 'package:konvertr/utils/theme.dart';

class UnitConverter extends StatelessWidget {
  const UnitConverter({Key key, this.convCategory}) : super(key: key);

  final Category convCategory;

  @override
  Widget build(BuildContext context) {
    AppBar _buildAppBar() {
      return AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          convCategory.name,
          style: GoogleFonts.roboto(
              letterSpacing: 1.5,
              color: searchBarColor,
              fontWeight: FontWeight.w600),
        ),
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: searchBarColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.favorite_border,
              color: searchBarColor,
            ),
          )
        ],
      );
    }

    Widget _buildConverterSelection() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "From",
            style: GoogleFonts.roboto(color: Colors.white),
          ),
          SizedBox(height: 10.0),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: Colors.white12,
            ),
            height: 0.05 * MediaQuery.of(context).size.height,
            width: 0.37 * MediaQuery.of(context).size.width,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Text(
                    "Lalalalaa",
                    style: TextStyle(color: Colors.white),
                  ),
                )),
          )
        ],
      );
    }

    Widget _buildTopSection() {
      return Container(
        height: 0.23 * MediaQuery.of(context).size.height,
        color: primaryColor,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildConverterSelection(),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Icon(
                    Icons.compare_arrows,
                    color: searchBarColor,
                    size: 32.0,
                  ),
                ),
                _buildConverterSelection()
              ],
            )
          ],
        ),
      );
    }

    Widget _buildTextFieldSection() {
      return Padding(
        padding: const EdgeInsets.only(top: 100.0, right: 16.0, left: 16.0),
        child: Card(
            child: Container(
          height: 200.0,
        )),
      );
    }

    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(children: [_buildTopSection(), _buildTextFieldSection()]),
    );
  }
}
