// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_quote_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchQuoteResponseModel _$SearchQuoteResponseModelFromJson(
        Map<String, dynamic> json) =>
    SearchQuoteResponseModel(
      count: json['count'] as int?,
      totalCount: json['totalCount'] as int?,
      page: json['page'] as int?,
      totalPages: json['totalPages'] as int?,
      lastItemIndex: json['lastItemIndex'] as int?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Quote.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchQuoteResponseModelToJson(
        SearchQuoteResponseModel instance) =>
    <String, dynamic>{
      'count': instance.count,
      'totalCount': instance.totalCount,
      'page': instance.page,
      'totalPages': instance.totalPages,
      'lastItemIndex': instance.lastItemIndex,
      'results': instance.results,
    };

Quote _$QuoteFromJson(Map<String, dynamic> json) => Quote(
      id: json['id'] as String?,
      content: json['content'] as String?,
      author: json['author'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      authorId: json['authorId'] as String?,
      authorSlug: json['authorSlug'] as String?,
      length: json['length'] as int?,
      dateAdded: json['dateAdded'] as String?,
      dateModified: json['dateModified'] as String?,
    );

Map<String, dynamic> _$QuoteToJson(Quote instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'author': instance.author,
      'tags': instance.tags,
      'authorId': instance.authorId,
      'authorSlug': instance.authorSlug,
      'length': instance.length,
      'dateAdded': instance.dateAdded,
      'dateModified': instance.dateModified,
    };
