import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quote_mobile_app/models/network/search_quote_response_model.dart';
import 'package:quote_mobile_app/modules/favourites_module/favourite_quotes_provider.dart';
import 'package:quote_mobile_app/modules/search_tab/search_quote_provider.dart';
import 'package:quote_mobile_app/utils/constants/app_contants.dart';
import 'package:quote_mobile_app/utils/custom_widgets/custom_list_tile.dart';
import 'package:quote_mobile_app/utils/utils.dart';

class SearchQuoteScreen extends StatefulWidget {
  const SearchQuoteScreen({Key? key}) : super(key: key);

  @override
  State<SearchQuoteScreen> createState() => _SearchQuoteScreenState();
}

class _SearchQuoteScreenState extends State<SearchQuoteScreen> {
  final TextEditingController _rangeController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _searchController.text = '';
    _rangeController.text = '10';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Quotes'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetConstants.kL15T15R15B5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Requested range: ',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    width: 50,
                    height: 40,
                    child: TextField(
                      controller: _rangeController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        isDense: true,
                      ),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetConstants.kAll15,
              child: SizedBox(
                height: kToolbarHeight,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          isDense: true,
                          suffix: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              Provider.of<SearchQuoteProvider>(
                                context,
                                listen: false,
                              ).getQuotes(
                                _searchController.text,
                                _rangeController.text,
                              );
                            },
                          ),
                        ),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            DividerConstants.kH2,
            Consumer<SearchQuoteProvider>(
              builder: (context, ref, child) {
                return Expanded(
                  child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      Quote quote = ref.quotes[index];
                      // return ListTile(
                      //   title: Text(quote.content ?? ''),
                      //   trailing: IconButton(
                      //     icon: const Icon(Icons.favorite_border),
                      //     onPressed: () {
                      //       addFavouriteQuote(index);
                      //     },
                      //   ),
                      // );
                      // Quote quote = ref.quotes[index];
                      return FutureBuilder(
                        future: Utils.isAlreadySaved(quote),
                        initialData: false,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          return CustomListTile(
                            type: Screens.search_tab,
                            index: index,
                            title: quote.content ?? '',
                            isSelected: (snapshot.data as bool),
                            deleteAction: addFavouriteQuote,
                            editAction: null,
                            selectAction: null,
                          );
                        },
                      );
                    },
                    itemCount: ref.quotes.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return DividerConstants.kH2;
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void addFavouriteQuote(int index) {
    Quote quote = Provider.of<SearchQuoteProvider>(
      context,
      listen: false,
    ).quotes[index];
    // insert quote
    Provider.of<SearchQuoteProvider>(
      context,
      listen: false,
    ).addToFavourites(quote).then((value) {
      // reload the favourite quotes
      Provider.of<FavouriteQuotesProvider>(
        context,
        listen: false,
      ).getFavouriteQuotes('');
      // show toast message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(value),
        ),
      );
      setState(() {});
    });
  }
}
