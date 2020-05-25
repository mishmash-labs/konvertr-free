import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:konvertr/components/converter_numpad.dart';
import 'package:konvertr/providers/converter_provider.dart';
import 'package:konvertr/utils/theme.dart';
import 'package:provider/provider.dart';

class UnitConverter extends StatelessWidget {
  const UnitConverter({Key key, this.categoryName}) : super(key: key);

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    ConverterProvider converterProvider = context.watch<ConverterProvider>();
    TextEditingController amountController = TextEditingController();

    AppBar _buildAppBar() {
      return AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          categoryName,
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

    Widget _buildConverterSelection(String whichUnit, String currentUnit) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            whichUnit,
            style: GoogleFonts.roboto(color: Colors.white70),
          ),
          SizedBox(height: 8.0),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        currentUnit,
                        style: TextStyle(
                            color: Colors.white70, fontWeight: FontWeight.w400),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white70,
                        size: 18.0,
                      )
                    ],
                  ),
                )),
          )
        ],
      );
    }

    Widget _buildTopSection() {
      return Container(
        height: 0.25 * MediaQuery.of(context).size.height,
        color: primaryColor,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildConverterSelection(
                    "From", converterProvider.fromUnit.name),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Icon(
                    Icons.swap_horiz,
                    color: searchBarColor,
                    size: 32.0,
                  ),
                ),
                _buildConverterSelection("To", converterProvider.toUnit.name)
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
          height: 210.0,
          width: double.infinity,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
            child: Column(
              children: [
                SizedBox(height: 5.0),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Amount",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                          letterSpacing: 1),
                    )),
                SizedBox(height: 5.0),
                InputDecorator(
                  child: Container(
                    child: Text(
                      converterProvider.inputValueString == null
                          ? ""
                          : converterProvider.inputValueString,
                    ),
                  ),
                  decoration: InputDecoration(
                    suffixText: converterProvider.fromUnit.symbol,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: primaryColor.withOpacity(0.5),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25.0),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Converted To",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                          letterSpacing: 1),
                    )),
                SizedBox(height: 5.0),
                InputDecorator(
                  child: Container(
                    child: Text(
                      converterProvider.convertedValue,
                    ),
                  ),
                  decoration: InputDecoration(
                    suffixText: converterProvider.toUnit.symbol,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: primaryColor.withOpacity(0.5),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      );
    }

    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Stack(children: [
            _buildTopSection(),
            _buildTextFieldSection(),
          ]),
          SizedBox(
            height: 100.0,
          ),
          Expanded(
              child: ConverterKeypad(
            amountController: amountController,
          )),
        ],
      ),
    );
  }
}
