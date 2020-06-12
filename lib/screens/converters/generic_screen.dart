import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../components/converter_numpad.dart';
import '../../providers/converter_provider.dart';
import '../../utils/theme.dart';
import '../units_screen.dart';

class UnitConverter extends StatelessWidget {
  const UnitConverter({Key key, this.categoryName}) : super(key: key);

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    ConverterProvider converterProvider = context.watch<ConverterProvider>();

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
          onPressed: () => Get.back(),
        ),
      );
    }

    Widget _buildConverterSelection(String whichUnit, String currentUnit) {
      return InkWell(
        onTap: () {
          Get.to(UnitsScreen(
            converterProvider: converterProvider,
            whichUnit: whichUnit,
            currentUnit: currentUnit,
          ));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              whichUnit,
              style: GoogleFonts.roboto(color: Colors.white70),
            ),
            SizedBox(height: 10 * Get.height / 798),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: Colors.white12,
              ),
              height: 40 * Get.height / 798,
              width: 0.4 * Get.width,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(
                      currentUnit,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.w400),
                    ),
                  )),
            )
          ],
        ),
      );
    }

    Widget _buildTopBackground() {
      return Container(
        height: 200 * Get.height / 798,
        color: primaryColor,
      );
    }

    Widget _buildTextFieldSection() {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
        child: Card(
            child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Amount",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                        letterSpacing: 1),
                  ),
                ),
                SizedBox(height: 6.0),
                Container(
                  height: 77 * Get.height / 798,
                  child: InputDecorator(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        converterProvider.inputValueString == null
                            ? ""
                            : converterProvider.inputValueString,
                        maxLines: 1,
                        style: TextStyle(color: primaryColor),
                      ),
                    ),
                    decoration: InputDecoration(
                      suffixText: converterProvider.fromUnit.symbol,
                      suffixStyle: TextStyle(color: primaryColor),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: primaryColor,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Converted To",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                          letterSpacing: 1),
                    )),
                SizedBox(height: 6.0),
                Container(
                  height: 77 * Get.height / 798,
                  child: InputDecorator(
                    child: Text(
                      converterProvider.convertedValue,
                      style: TextStyle(color: primaryColor),
                    ),
                    decoration: InputDecoration(
                      suffixText: converterProvider.toUnit.symbol,
                      suffixStyle: TextStyle(color: primaryColor),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: primaryColor,
                          width: 1.5,
                        ),
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

    Widget _buildTopSection() {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildConverterSelection("From", converterProvider.fromUnit.name),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: InkWell(
                  onTap: () {
                    String tempTo = converterProvider.toUnit.name;
                    converterProvider
                        .updateToUnit(converterProvider.fromUnit.name);
                    converterProvider.updateFromUnit(tempTo);
                  },
                  child: Icon(
                    Icons.swap_horiz,
                    color: searchBarColor,
                    size: 28.0,
                  ),
                ),
              ),
              _buildConverterSelection("To", converterProvider.toUnit.name)
            ],
          ),
          _buildTextFieldSection()
        ],
      );
    }

    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(children: [
            _buildTopBackground(),
            _buildTopSection(),
          ]),
          ConverterKeypad(),
        ],
      ),
    );
  }
}
