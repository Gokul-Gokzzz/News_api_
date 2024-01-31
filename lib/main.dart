import 'package:flutter/material.dart';
import 'package:news_api/controller/app_bar_provider.dart';
import 'package:news_api/controller/category-list_provider.dart';

import 'package:news_api/view/splash.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => appBarProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryListProvider(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
