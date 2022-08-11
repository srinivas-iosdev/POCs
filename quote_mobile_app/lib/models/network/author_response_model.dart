import 'package:json_annotation/json_annotation.dart';
part 'author_response_model.g.dart';

@JsonSerializable()
class AuthorResponseModel {
  AuthorResponseModel({
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
  dynamic lastItemIndex;
  List<Author>? results;

  factory AuthorResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthorResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$AuthorResponseModelToJson(this);
}

@JsonSerializable()
class Author {
  Author({
    this.id,
    this.name,
    this.link,
    this.bio,
    this.description,
    this.quoteCount,
    this.slug,
    this.dateAdded,
    this.dateModified,
  });

  @JsonKey(name: '_id')
  String? id;
  String? name;
  String? link;
  String? bio;
  String? description;
  int? quoteCount;
  String? slug;
  String? dateAdded;
  String? dateModified;

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);
  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}
