// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_api/controller/app_bar_provider.dart';
import 'package:news_api/model/categories_news_model.dart';
import 'package:news_api/model/news_channel_headline_model.dart';
import 'package:news_api/view/category_detaile/category_detail_screen.dart';
import 'package:news_api/view/home_screen/caterory_news_model.dart';
import 'package:news_api/view/news_detaile/news_detaile_screen.dart';
import 'package:news_api/view/widget/app_bar.dart';
import 'package:news_api/view_model/news_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  NewsModel newsViewModel = NewsModel();

  FilterList? selectedMenu;

  final format = DateFormat('MMMM dd, yyyy');

  String name = 'bbc-news';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
        appBar: appbar(context),
        body: Consumer<appBarProvider>(builder: (context, value, child) {
          return ListView(
            children: [
              SizedBox(
                height: height * .55,
                width: width,
                child: FutureBuilder<NewsChannelsHeadlinesModel>(
                    future: newsViewModel.NewsChannelHeadlinesApi(value.name),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: SpinKitFadingCube(
                            size: 40,
                            color: Colors.blue,
                          ),
                        );
                      } else {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.articles!.length,
                            itemBuilder: (context, index) {
                              DateTime dateTime = DateTime.parse(snapshot
                                  .data!.articles![index].publishedAt
                                  .toString());
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NewsDetailesScreen(
                                              newsImage: snapshot
                                                      .data!
                                                      .articles![index]
                                                      .urlToImage ??
                                                  "",
                                              newsTitle: snapshot
                                                  .data!.articles![index].title
                                                  .toString(),
                                              newsDate: snapshot.data!
                                                  .articles![index].publishedAt
                                                  .toString(),
                                              author: snapshot
                                                  .data!.articles![index].author
                                                  .toString(),
                                              description: snapshot.data!
                                                  .articles![index].description
                                                  .toString(),
                                              content: snapshot.data!.articles![index].content.toString(),
                                              source: snapshot.data!.articles![index].source.toString())));
                                },
                                child: SizedBox(
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        height: height * 0.6,
                                        width: width * .9,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: height * 0.02),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: CachedNetworkImage(
                                            imageUrl: snapshot.data!
                                                .articles![index].urlToImage
                                                .toString(),
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Container(
                                              child: spinkit2,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(
                                              Icons.error_outline,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 20,
                                        child: Card(
                                          elevation: 5,
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Container(
                                            alignment: Alignment.bottomCenter,
                                            padding: const EdgeInsets.all(15),
                                            height: height * 0.22,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: width * 0.7,
                                                  child: Text(
                                                    snapshot.data!
                                                        .articles![index].title
                                                        .toString(),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                                const Spacer(),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        snapshot
                                                            .data!
                                                            .articles![index]
                                                            .source!
                                                            .name
                                                            .toString(),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                      Text(
                                                        format.format(dateTime),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                    }),
              ),
              categoryBuilder(height, width),
            ],
          );
        }));
  }
}

enum FilterList {
  bbcNews,
  aryNews,
  aljazeera,
  independent,
  cnn,
  reuters,
}

const spinkit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);
