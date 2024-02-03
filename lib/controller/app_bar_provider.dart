// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:news_api/view/home_screen/home.dart';

class appBarProvider extends ChangeNotifier {
  String name = 'bbc-news';
  appBar(newsname) {
    name = newsname;
    notifyListeners();
  }

  FilterList? selectedMenu;
  popup(item) {
    selectedMenu = item;
    notifyListeners();
  }
}
