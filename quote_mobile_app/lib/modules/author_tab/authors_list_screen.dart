import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quote_mobile_app/models/network/author_response_model.dart';
import 'package:quote_mobile_app/modules/author_tab/authors_list_provider.dart';
import 'package:quote_mobile_app/utils/constants/app_contants.dart';

class AuthorsListScreen extends StatefulWidget {
  const AuthorsListScreen({Key? key}) : super(key: key);

  @override
  State<AuthorsListScreen> createState() => _AuthorsListScreenState();
}

class _AuthorsListScreenState extends State<AuthorsListScreen> {
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
        minimum: EdgeInsetConstants.kAll10,
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
                              Provider.of<AuthorsListProvider>(
                                context,
                                listen: false,
                              ).getQuotes(_searchController.text);
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
            Consumer<AuthorsListProvider>(
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
                    child: ListView.separated(
                      itemCount: ref.authors.length,
                      itemBuilder: (BuildContext context, int index) {
                        Author author = ref.authors[index];
                        return ListTile(
                          title: Text(author.name ?? ''),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return DividerConstants.kH2;
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
