// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorResponseModel _$AuthorResponseModelFromJson(Map<String, dynamic> json) =>
    AuthorResponseModel(
      count: json['count'] as int?,
      totalCount: json['totalCount'] as int?,
      page: json['page'] as int?,
      totalPages: json['totalPages'] as int?,
      lastItemIndex: json['lastItemIndex'],
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Author.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AuthorResponseModelToJson(
        AuthorResponseModel instance) =>
    <String, dynamic>{
      'count': instance.count,
      'totalCount': instance.totalCount,
      'page': instance.page,
      'totalPages': instance.totalPages,
      'lastItemIndex': instance.lastItemIndex,
      'results': instance.results,
    };

Author _$AuthorFromJson(Map<String, dynamic> json) => Author(
      id: json['id'] as String?,
      name: json['name'] as String?,
      link: json['link'] as String?,
      bio: json['bio'] as String?,
      description: json['description'] as String?,
      quoteCount: json['quoteCount'] as int?,
      slug: json['slug'] as String?,
      dateAdded: json['dateAdded'] as String?,
      dateModified: json['dateModified'] as String?,
    );

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'link': instance.link,
      'bio': instance.bio,
      'description': instance.description,
      'quoteCount': instance.quoteCount,
      'slug': instance.slug,
      'dateAdded': instance.dateAdded,
      'dateModified': instance.dateModified,
    };
