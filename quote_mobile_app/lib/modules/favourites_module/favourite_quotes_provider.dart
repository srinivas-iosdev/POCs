import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:quote_mobile_app/repository/localdb/db_manager.dart';
import 'package:quote_mobile_app/repository/localdb/tables/favourite_quote.dart';

class FavouriteQuotesProvider extends ChangeNotifier {
  List<FavouriteQuote> _quotesArray = [];
  UnmodifiableListView<FavouriteQuote> get quotes =>
      UnmodifiableListView(_quotesArray);

  void init() {
    // Get latest data
    getFavouriteQuotes('');
  }

  void getFavouriteQuotes(String searchKey) {
    DBManager().fetchQuotes(searchKey, 'content').then(
      (value) {
        _quotesArray = value ?? [];
        notifyListeners();
      },
    );
  }

  Future<bool> searchFavouriteQuotes(String searchKey) async {
    final quotes = await DBManager().fetchQuotes(searchKey, 'id') ?? [];
    return quotes.isNotEmpty;
  }

  void insertQuote(FavouriteQuote quote) {
    DBManager().insertQuote(quote).then(
      (value) {
        getFavouriteQuotes('');
      },
    );
  }

  void updateQuote(FavouriteQuote quote) {
    DBManager().updateQuote(quote).then(
      (value) {
        getFavouriteQuotes('');
      },
    );
  }

  void deleteQuote(FavouriteQuote quote) {
    DBManager().deleteQuote(quote).then(
      (value) {
        getFavouriteQuotes('');
      },
    );
  }

  void deleteAllQuote() {
    DBManager().deleteAllQuotes().then(
      (value) {
        getFavouriteQuotes('');
      },
    );
  }
}
