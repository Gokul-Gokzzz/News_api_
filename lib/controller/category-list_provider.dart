// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CategoryListProvider extends ChangeNotifier {
  List<String> categoriesList = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology'
  ];
  String categoryName = 'general';
  list(index) {
    categoryName = categoriesList[index];
    notifyListeners();
  }
}
