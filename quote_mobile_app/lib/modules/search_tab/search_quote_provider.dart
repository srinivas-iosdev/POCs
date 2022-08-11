import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quote_mobile_app/models/network/search_quote_response_model.dart';
import 'package:quote_mobile_app/network/http_service.dart';

class SearchQuoteProvider with ChangeNotifier {
  List<Quote> _quotesArray = [];
  UnmodifiableListView<Quote> get quotes => UnmodifiableListView(_quotesArray);

  void getQuotes(String quoteName, String range) {
    // https://api.quotable.io/search/quotes?query=love&limit=10
    Map<String, String> request = {
      "query": quoteName,
      "limit": range,
    };
    String baseURL = "api.quotable.io";
    String endPoint = "/search/quotes";

    HttpService.sharedInstance.apiGetRequest(request, endPoint, baseURL).then(
      (response) {
        List<Quote>? quotes =
            SearchQuoteResponseModel.fromJson(jsonDecode(response.response))
                .results;

        _quotesArray = quotes ?? [];

        notifyListeners();
      },
    );
  }
}
