import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:konvertr/models/category.dart';
import 'package:konvertr/providers/converter_provider.dart';
import 'package:konvertr/screens/converter_screen.dart';
import 'package:konvertr/utils/theme.dart';
import 'package:provider/provider.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({Key key, this.convCategory}) : super(key: key);

  final Category convCategory;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
              create: (context) => ConverterProvider(convCategory.units),
              child: UnitConverter(categoryName: convCategory.name)),
        ));
      },
      child: Card(
        color: tertiaryColor,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              "assets/icons/${convCategory.name}.png",
              color: quaternaryColor,
              height: 0.06 * MediaQuery.of(context).size.height,
              width: 0.06 * MediaQuery.of(context).size.height,
            ),
            Text(
              convCategory.name,
              style: GoogleFonts.roboto(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w800,
                  color: quaternaryColor),
            )
          ],
        ),
      ),
    );
  }
}
