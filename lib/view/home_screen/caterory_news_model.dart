import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_api/model/categories_news_model.dart';
import 'package:news_api/view/category_detaile/category_detail_screen.dart';
import 'package:news_api/view/home_screen/home.dart';
import 'package:news_api/view_model/news_view_model.dart';

Padding categoryBuilder(double height, double width) {
  NewsModel newsViewModel = NewsModel();

  final format = DateFormat('MMMM dd, yyyy');
  return Padding(
    padding: const EdgeInsets.all(20),
    child: FutureBuilder<CategoriesNewsModel>(
        future: newsViewModel.categoriesNewsApi('General'),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SpinKitFadingCube(
                size: 50,
                color: Colors.blue,
              ),
            );
          } else if (snapshot.hasError || snapshot.data == null) {
            return const Center(
              child: Text("Error loading data"),
            );
          } else {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.articles!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DateTime dateTime = DateTime.parse(
                      snapshot.data!.articles![index].publishedAt.toString());
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoryDetaileScreen(
                                  newsImage: snapshot.data!.articles![index].urlToImage ??
                                      "",
                                  newsTitle: snapshot.data!.articles![index].title
                                      .toString(),
                                  newsDate: snapshot
                                      .data!.articles![index].publishedAt
                                      .toString(),
                                  author: snapshot.data!.articles![index].author
                                      .toString(),
                                  description: snapshot
                                      .data!.articles![index].description
                                      .toString(),
                                  content: snapshot.data!.articles![index].content
                                      .toString(),
                                  source: snapshot.data!.articles![index].source
                                      .toString())));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              imageUrl:
                                  snapshot.data!.articles![index].urlToImage ??
                                      "",
                              fit: BoxFit.cover,
                              height: height * .18,
                              width: width * .3,
                              placeholder: (context, url) => Container(
                                child: spinkit2,
                              ),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error_outline,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          Expanded(
                              child: Container(
                            height: height * .18,
                            padding: const EdgeInsets.only(left: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data!.articles![index].title
                                      .toString(),
                                  maxLines: 3,
                                  style: GoogleFonts.poppins(
                                      fontSize: 19,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  format.format(dateTime),
                                  style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500),
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      snapshot
                                          .data!.articles![index].source!.name
                                          .toString(),
                                      style: GoogleFonts.poppins(
                                          fontSize: 10,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                  );
                });
          }
        }),
  );
}
