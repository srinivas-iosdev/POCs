import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quote_mobile_app/modules/home_screen.dart';
import 'package:quote_mobile_app/modules/author_tab/authors_list_provider.dart';
import 'package:quote_mobile_app/modules/favourites_module/favourite_quotes_provider.dart';
import 'package:quote_mobile_app/modules/search_tab/search_quote_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => AuthorsListProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => SearchQuoteProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => FavouriteQuotesProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
