// ignore_for_file: non_constant_identifier_names

import 'package:news_api/controller/controller.dart';
import 'package:news_api/model/categories_news_model.dart';
import 'package:news_api/model/news_channel_headline_model.dart';

class NewsModel {
  final _res = NewsProvider();
  Future<NewsChannelsHeadlinesModel> NewsChannelHeadlinesApi(
      String channelName) async {
    final response = await _res.NewsChannelHeadlinesApi(channelName);
    return response;
  }

  Future<CategoriesNewsModel> categoriesNewsApi(String categoryName) async {
    final response = await _res.CategoriesNewsApi(categoryName);
    return response;
  }
}
