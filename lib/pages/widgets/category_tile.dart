import "package:flutter/material.dart";
import "package:pos/models/category_model.dart";
import "package:pos/providers/category_provider.dart";
import "package:provider/provider.dart";
import 'package:pos/theme.dart';

class CategoryTile extends StatelessWidget {
  @override
  final CategoryModel categoryList;

  CategoryTile(this.categoryList);
  Widget build(BuildContext context) {
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    return GestureDetector(
      onTap: () {
        categoryProvider.selectCategory = categoryList.id!;
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          margin: EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            // isSelected ? (color: primaryColor) : (color: backgroundColor4),) ,
            border: Border.all(
              color: subtitleColor,
            ),
            color: categoryProvider.selectCategory == categoryList.id
                ? primaryColor
                : backgroundColor4,
          ),
          child: Text(
            '${categoryList.name}',
            style: primaryTextStyle.copyWith(fontSize: 13, fontWeight: medium),
          )),
    );
  }
}
