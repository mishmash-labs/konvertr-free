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
            SizedBox(height: 8.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: Colors.white12,
              ),
              height: 0.05 * Get.height,
              width: 0.4 * Get.width,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          currentUnit,
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w400),
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
        ),
      );
    }

    Widget _buildTopSection() {
      return Container(
        height: 0.25 * Get.height,
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
                    size: 28.0,
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
        padding:
            EdgeInsets.only(top: 0.13 * Get.height, right: 16.0, left: 16.0),
        child: Card(
            child: Container(
          height: 0.27 * Get.height,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Amount",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                          letterSpacing: 1),
                    )),
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
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Converted To",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                          letterSpacing: 1),
                    )),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(children: [
            _buildTopSection(),
            _buildTextFieldSection(),
          ]),
          ConverterKeypad(),
        ],
      ),
    );
  }
}
