import 'package:quote_mobile_app/models/network/search_quote_response_model.dart';
import 'package:quote_mobile_app/repository/localdb/db_manager.dart';
import 'package:quote_mobile_app/repository/localdb/tables/favourite_quote.dart';

class Utils {
  static FavouriteQuote convert(Quote quote) {
    return FavouriteQuote(
      id: quote.id,
      content: quote.content,
      author: quote.author,
      length: quote.length,
      dateAdded: quote.dateAdded,
      dateModified: quote.dateModified,
    );
  }

  static Future<bool> isAlreadySaved(Quote quote) async {
    List<FavouriteQuote> quo =
        await DBManager().fetchQuotes(quote.id ?? '', 'id') ?? [];
    return quo.isNotEmpty;
  }
}
