import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/category.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({Key key, this.convCategory}) : super(key: key);

  final Category convCategory;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
            color: Colors.white10, width: 1.0, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            convCategory.icon,
            color: Colors.white38,
            size: 0.05625 * Get.height,
          ),
          Text(
            convCategory.name,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: Colors.white60,
            ),
          )
        ],
      ),
    );
  }
}
