import 'package:flutter/material.dart';

class CategoryItem {
  String title;
  List<SubCategoryItem> subCategories;
  bool isExpanded;
  Color color;

  CategoryItem({this.title, this.subCategories, this.isExpanded, this.color});
}

class SubCategoryItem {
  String title;
  int id;

  SubCategoryItem({this.title, this.id});
}
