import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quote_mobile_app/models/network/search_quote_response_model.dart';
import 'package:quote_mobile_app/modules/favourites_module/favourite_quotes_provider.dart';
import 'package:quote_mobile_app/modules/search_tab/search_quote_provider.dart';
import 'package:quote_mobile_app/repository/localdb/tables/favourite_quote.dart';

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
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
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
                        filled: true,
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
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                height: kToolbarHeight,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          filled: true,
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
            const Divider(
              height: 2,
              color: Colors.grey,
            ),
            Consumer<SearchQuoteProvider>(
              builder: (context, ref, child) {
                return Expanded(
                  child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      Quote quote = ref.quotes[index];
                      Future<bool> isInLocal =
                          Provider.of<FavouriteQuotesProvider>(context)
                              .searchFavouriteQuotes(quote.id ?? '');
                      return ListTile(
                        title: Text(quote.content ?? ''),
                        trailing: IconButton(
                          icon: const Icon(Icons.favorite_border),
                          onPressed: () {
                            // insert quote
                            FavouriteQuote favQuote =
                                FavouriteQuote().fromJson(quote.toJson());
                            Provider.of<FavouriteQuotesProvider>(context)
                                .insertQuote(favQuote);
                            // show toast
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Added to Favourites'),
                              ),
                            );
                          },
                        ),
                      );
                    },
                    itemCount: ref.quotes.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        height: 2,
                        color: Colors.grey,
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
