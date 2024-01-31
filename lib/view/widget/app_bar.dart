import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_api/controller/app_bar_provider.dart';

import 'package:news_api/view/category_screen.dart';
import 'package:news_api/view/home.dart';
import 'package:provider/provider.dart';

// FilterList? selectedMenu;

appbar(context) {
  return AppBar(
    actions: [
      Consumer<appBarProvider>(
          builder: (context, value, child) => PopupMenuButton<FilterList>(
              initialValue: value.selectedMenu,
              icon: const Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              onSelected: (FilterList item) {
                if (FilterList.bbcNews.name == item.name) {
                  value.appBar("bbc-news");
                }
                if (FilterList.aryNews.name == item.name) {
                  value.appBar("ary-news");
                }
                if (FilterList.aljazeera.name == item.name) {
                  value.appBar("al-jazeera-english");
                }
                if (FilterList.cnn.name == item.name) {
                  value.appBar("cnn");
                }

                value.popup(item);
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<FilterList>>[
                    const PopupMenuItem<FilterList>(
                      value: FilterList.bbcNews,
                      child: Text('BBC NEWS'),
                    ),
                    const PopupMenuItem<FilterList>(
                      value: FilterList.aryNews,
                      child: Text('ARY NEWS'),
                    ),
                    const PopupMenuItem<FilterList>(
                      value: FilterList.aljazeera,
                      child: Text('ALJAZEERA NEWS'),
                    ),
                    const PopupMenuItem<FilterList>(
                      value: FilterList.cnn,
                      child: Text('CNN NEWS'),
                    ),
                  ]))
    ],
    leading: IconButton(
      onPressed: () {
        Navigator.push(context as BuildContext,
            MaterialPageRoute(builder: (context) => CategoryScreen()));
      },
      icon: Image.asset(
        'assets/category_icon.png',
        height: 30,
        width: 30,
      ),
    ),
    title: Text(
      'NEWS',
      style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
    ),
    centerTitle: true,
  );
}
