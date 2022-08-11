import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quote_mobile_app/models/network/author_response_model.dart';
import 'package:quote_mobile_app/repository/network/http_manager.dart';

class AuthorsListProvider with ChangeNotifier {
  List<Author> _authorsArray = [];
  UnmodifiableListView<Author> get authors =>
      UnmodifiableListView(_authorsArray);

  void getQuotes(String quoteName) {
    // https://api.quotable.io/search/authors?query=Einstein
    Map<String, String> request = {
      "query": quoteName,
    };
    String baseURL = "api.quotable.io";
    String endPoint = "/search/authors";

    HttpManager.sharedInstance.apiGetRequest(request, endPoint, baseURL).then(
      (response) {
        List<Author> authors =
            AuthorResponseModel.fromJson(jsonDecode(response.response))
                    .results ??
                [];
        _authorsArray = authors;
        notifyListeners();
      },
    );
  }
}
