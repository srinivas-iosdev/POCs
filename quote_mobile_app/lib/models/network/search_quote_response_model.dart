import 'package:json_annotation/json_annotation.dart';
part 'search_quote_response_model.g.dart';

@JsonSerializable()
class SearchQuoteResponseModel {
  SearchQuoteResponseModel({
    this.count,
    this.totalCount,
    this.page,
    this.totalPages,
    this.lastItemIndex,
    this.results,
  });

  int? count;
  int? totalCount;
  int? page;
  int? totalPages;
  int? lastItemIndex;
  List<Quote>? results;

  factory SearchQuoteResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SearchQuoteResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$SearchQuoteResponseModelToJson(this);
}

@JsonSerializable()
class Quote {
  Quote({
    this.id,
    this.content,
    this.author,
    this.tags,
    this.authorId,
    this.authorSlug,
    this.length,
    this.dateAdded,
    this.dateModified,
  });

  @JsonKey(name: '_id')
  String? id;
  String? content;
  String? author;
  List<String>? tags;
  String? authorId;
  String? authorSlug;
  int? length;
  String? dateAdded;
  String? dateModified;

  factory Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);
  Map<String, dynamic> toJson() => _$QuoteToJson(this);
}
