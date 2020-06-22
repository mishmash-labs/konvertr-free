import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../components/converter_numpad.dart';
import '../../providers/converter_provider.dart';
import '../units_screen.dart';

class UnitConverter extends StatelessWidget {
  const UnitConverter({Key key, this.categoryName}) : super(key: key);

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    ConverterProvider convProvider =
        Provider.of<ConverterProvider>(context, listen: false);

    AppBar _buildAppBar() {
      return AppBar(
        backgroundColor: Get.theme.primaryColor,
        centerTitle: true,
        title: Text(
          categoryName,
          style: TextStyle(
              letterSpacing: 1.5,
              color: Colors.white70,
              fontWeight: FontWeight.w600),
        ),
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white70,
          ),
          onPressed: () => Get.back(),
        ),
      );
    }

    Widget _buildConverterSelection(String whichUnit, String currentUnit) {
      return InkWell(
        onTap: () {
          Get.to(UnitsScreen(
            converterProvider: convProvider,
            whichUnit: whichUnit,
            currentUnit: currentUnit,
          ));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              whichUnit,
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 0.01 * Get.height),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: Colors.white12,
              ),
              height: 0.05 * Get.height,
              width: 0.41 * Get.width,
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
        height: 0.25 * Get.height,
        color: Get.theme.primaryColor,
      );
    }

    Widget _buildTextFieldSection() {
      return Padding(
        padding: EdgeInsets.symmetric(
            vertical: Get.height * 0.035, horizontal: 16.0),
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            elevation: 3.0,
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "amount",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Get.theme.primaryColor,
                            letterSpacing: 1),
                      ),
                    ),
                    SizedBox(height: 6.0),
                    Consumer<ConverterProvider>(
                      builder: (_, conv, __) => InputDecorator(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            conv.inputValueString == null
                                ? ""
                                : conv.inputValueString,
                            maxLines: 1,
                            style: TextStyle(color: Get.theme.primaryColor),
                          ),
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          suffixText: conv.fromUnit.symbol,
                          suffixStyle: TextStyle(color: Get.theme.primaryColor),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Get.theme.primaryColor,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "converted to",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Get.theme.primaryColor,
                            letterSpacing: 1),
                      ),
                    ),
                    SizedBox(height: 6.0),
                    Consumer<ConverterProvider>(
                      builder: (_, conv, __) => InputDecorator(
                        child: Text(
                          conv.convertedValue,
                          style: TextStyle(color: Get.theme.primaryColor),
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          suffixText: conv.toUnit.symbol,
                          suffixStyle: TextStyle(color: Get.theme.primaryColor),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Get.theme.primaryColor,
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
              Consumer<ConverterProvider>(
                builder: (_, conv, __) => _buildConverterSelection(
                    "from", conv.fromUnit.name.toLowerCase()),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: InkWell(
                  onTap: () {
                    String tempTo = convProvider.toUnit.name;
                    convProvider.updateToUnit(convProvider.fromUnit.name);
                    convProvider.updateFromUnit(tempTo);
                  },
                  child: Icon(
                    Icons.swap_horiz,
                    color: Colors.white60,
                    size: 28.0,
                  ),
                ),
              ),
              Consumer<ConverterProvider>(
                builder: (_, conv, __) => _buildConverterSelection(
                    "to", conv.toUnit.name.toLowerCase()),
              )
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
          RepaintBoundary(child: ConverterKeypad()),
        ],
      ),
    );
  }
}
