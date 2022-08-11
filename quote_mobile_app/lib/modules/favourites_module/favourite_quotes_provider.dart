import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:quote_mobile_app/models/network/search_quote_response_model.dart';

class FavouriteQuotesProvider extends ChangeNotifier {
  final List<Quote> _quotesArray = [];
  UnmodifiableListView<Quote> get quotes => UnmodifiableListView(_quotesArray);

  void getFavouriteQuotes(String quoteName) {
    // Map<String, String> request = {
    //   "query": quoteName,
    // };

    // HttpService.sharedInstance.apiGetRequest(request, endPoint, baseURL).then(
    //   (response) {
    //     List<Quote>? quotes =
    //         SearchQuoteResponseModel.fromJson(jsonDecode(response.response))
    //             .results;

    //     _quotesArray = quotes ?? [];

    //     notifyListeners();
    //   },
    // );
  }
}
