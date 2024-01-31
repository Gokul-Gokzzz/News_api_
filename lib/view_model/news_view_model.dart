import 'package:news_api/controller/controller.dart';
import 'package:news_api/model/categories_news_model.dart';
import 'package:news_api/model/news_channel_headline_model.dart';

class NewsModel {
  final _res = NewsProvider();
  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesApi(
      String channelName) async {
    final response = await _res.fetchNewsChannelHeadlinesApi(channelName);
    return response;
  }

  Future<CategoriesNewsModel> fetchcategoriesNewsApi(
      String categoryName) async {
    final response = await _res.fetchCategoriesNewsApi(categoryName);
    return response;
  }
}
