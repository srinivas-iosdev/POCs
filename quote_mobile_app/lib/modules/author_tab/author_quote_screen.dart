import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quote_mobile_app/models/network/author_response_model.dart';
import 'package:quote_mobile_app/modules/author_tab/author_quote_provider.dart';

class AuthorQuoteScreen extends StatefulWidget {
  const AuthorQuoteScreen({Key? key}) : super(key: key);

  @override
  State<AuthorQuoteScreen> createState() => _AuthorQuoteScreenState();
}

class _AuthorQuoteScreenState extends State<AuthorQuoteScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _searchController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Authors List'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Search quotes using author name',
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
                              Provider.of<AuthorQuoteProvider>(context,
                                      listen: false)
                                  .getQuotes(_searchController.text);
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
            Consumer<AuthorQuoteProvider>(
              builder: (context, ref, child) {
                if (ref.authors.isEmpty) {
                  return Center(
                    child: Text(
                      _searchController.text.isEmpty
                          ? ''
                          : 'No Results Found!!',
                    ),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: ref.authors.length,
                      itemBuilder: (BuildContext context, int index) {
                        Author author = ref.authors[index];
                        return ListTile(
                          title: Text(author.name ?? ''),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
