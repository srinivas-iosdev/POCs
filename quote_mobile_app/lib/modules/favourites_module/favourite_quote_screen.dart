import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quote_mobile_app/modules/favourites_module/favourite_quotes_provider.dart';
import 'package:quote_mobile_app/repository/localdb/tables/favourite_quote.dart';
import 'package:quote_mobile_app/utils/constants/app_contants.dart';
import 'package:quote_mobile_app/utils/custom_widgets/custom_list_tile.dart';

class FavouriteQuoteScreen extends StatefulWidget {
  const FavouriteQuoteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteQuoteScreen> createState() => _FavouriteQuoteScreenState();
}

class _FavouriteQuoteScreenState extends State<FavouriteQuoteScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<int> quoteIndexes = [];
  int? editingQuoteIndex;
  int? deleteQuoteIndex;

  @override
  void initState() {
    _searchController.text = '';

    super.initState();
    // Fetch data on launch
    Provider.of<FavouriteQuotesProvider>(context, listen: false)
        .getFavouriteQuotes('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Quotes'),
        actions: [
          Visibility(
            visible: true,
            child: IconButton(
              onPressed: deleteSelectedQuotes,
              icon: const Icon(Icons.delete),
            ),
          ),
        ],
      ),
      body: SafeArea(
        minimum: EdgeInsetConstants.kAll10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Search favourite quotes',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
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
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          isDense: true,
                          suffix: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              Provider.of<FavouriteQuotesProvider>(
                                context,
                                listen: false,
                              ).getFavouriteQuotes(_searchController.text);
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
            Consumer<FavouriteQuotesProvider>(
              builder: (context, ref, child) {
                return Expanded(
                  child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      FavouriteQuote quote = ref.quotes[index];
                      return CustomListTile(
                        type: Screens.favourites_tab,
                        index: index,
                        title: quote.content ?? '',
                        isSelected: isQuoteSelected(index),
                        deleteAction: deleteQuote,
                        editAction: editQuote,
                        selectAction: selectQuote,
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

  bool isQuoteSelected(int index) {
    return quoteIndexes.contains(index);
  }

  void deleteSelectedQuotes() {
    List<FavouriteQuote> favQuotes = Provider.of<FavouriteQuotesProvider>(
      context,
      listen: false,
    ).quotes;

    if (quoteIndexes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Select quotes you want to delete'),
        ),
      );
    } else {
      if (quoteIndexes.length == favQuotes.length) {
        Provider.of<FavouriteQuotesProvider>(context).deleteAllQuote();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('All quotes deleted'),
          ),
        );
      } else {
        for (int i = 0; i < quoteIndexes.length; i++) {
          deleteQuote(i);
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Selected quotes deleted'),
          ),
        );
      }
    }
    quoteIndexes.clear();
  }

  void selectQuote(int index) {
    if (quoteIndexes.contains(index)) {
      quoteIndexes.remove(index);
    } else {
      quoteIndexes.add(index);
    }
    setState(() {});
  }

  void deleteQuote(int index) {
    FavouriteQuote favQuote = Provider.of<FavouriteQuotesProvider>(
      context,
      listen: false,
    ).quotes[index];
    Provider.of<FavouriteQuotesProvider>(
      context,
      listen: false,
    ).deleteQuote(favQuote);
    quoteIndexes.remove(index);
  }

  void editQuote(int index) async {
    final String? userQuote = await showDialog(
      context: context,
      builder: (BuildContext context) {
        String quote = '';
        return AlertDialog(
          content: TextField(
            onChanged: (value) => quote = value,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(quote);
                },
                child: const Text('Update')),
          ],
        );
      },
    );

    if (userQuote?.isEmpty ?? true) {
      return;
    }
    FavouriteQuote quote = Provider.of<FavouriteQuotesProvider>(
      context,
      listen: false,
    ).quotes[index];
    quote.content = userQuote;
    Provider.of<FavouriteQuotesProvider>(
      context,
      listen: false,
    ).updateQuote(quote);
  }
}
