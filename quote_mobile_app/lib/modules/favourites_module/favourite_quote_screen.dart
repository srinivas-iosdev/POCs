import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quote_mobile_app/modules/favourites_module/favourite_quotes_provider.dart';

class FavouriteQuoteScreen extends StatefulWidget {
  const FavouriteQuoteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteQuoteScreen> createState() => _FavouriteQuoteScreenState();
}

class _FavouriteQuoteScreenState extends State<FavouriteQuoteScreen> {
  final TextEditingController _searchController = TextEditingController();

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
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(10),
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
                              Provider.of<FavouriteQuotesProvider>(context,
                                      listen: false)
                                  .getFavouriteQuotes(_searchController.text);
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
            Consumer<FavouriteQuotesProvider>(
              builder: (context, ref, child) {
                return const Text('');
              },
            ),
          ],
        ),
      ),
    );
  }
}
