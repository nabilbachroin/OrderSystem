import 'package:flutter/material.dart';

class CategoryModel {
  String name;
  String iconPath;
  Color boxColor;

  CategoryModel({
    required this.name, 
    required this.iconPath,
    required this.boxColor
  });

  static List<CategoryModel> getCategories() {
    List<CategoryModel> categories = [];

    categories.add(CategoryModel(
      name: 'Frozen Foods',
      iconPath: 'assets/icons/plate.svg',
      boxColor: const Color(0xffFFE3E3),
    ));

    categories.add(CategoryModel(
      name: 'Fried food',
      iconPath: 'assets/icons/pancakes.svg',
      boxColor: const Color(0xffE3F7FF),
    ));

    categories.add(CategoryModel(
      name: 'Palm Oil',
      iconPath: 'assets/icons/pie.svg',
      boxColor: const Color(0xffFFF3E3),
    ));

    categories.add(CategoryModel(
      name: 'Beverages',
      iconPath: 'assets/icons/orange-snacks.svg',
      boxColor: const Color(0xffE3FFEB),
    ));

    return categories;
  }
}