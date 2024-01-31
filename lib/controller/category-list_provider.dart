import 'package:flutter/material.dart';

class CategoryListProvider extends ChangeNotifier {
  List<String> CategoriesList = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology'
  ];
  String categoryName = 'general';
  list(index) {
    categoryName = CategoriesList[index];
    notifyListeners();
  }
}
