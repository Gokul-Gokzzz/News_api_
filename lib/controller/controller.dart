// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:news_api/model/categories_news_model.dart';
import 'package:news_api/model/news_channel_headline_model.dart';
import 'package:news_api/service/news_service.dart';

class NewsProvider extends ChangeNotifier {
  final Service _Service = Service();

  Future<NewsChannelsHeadlinesModel> NewsChannelHeadlinesApi(
      String channelName) async {
    try {
      return await _Service.newsChannelHeadlinesApi(channelName);
    } catch (e) {
      throw Exception('Error fetching news channel headlines');
    }
  }

  Future<CategoriesNewsModel> CategoriesNewsApi(String category) async {
    try {
      return await _Service.categoriesNewsApi(category);
    } catch (e) {
      throw Exception('Error fetching category news');
    }
  }
}
