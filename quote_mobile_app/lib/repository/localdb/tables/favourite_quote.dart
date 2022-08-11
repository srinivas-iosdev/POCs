class FavouriteQuote {
  FavouriteQuote({
    this.id,
    this.content,
    this.author,
    this.length,
    this.dateAdded,
    this.dateModified,
  });

  String? id;
  String? content;
  String? author;
  int? length;
  String? dateAdded;
  String? dateModified;

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? 0,
      'content': content ?? '',
      'author': author ?? '',
      'length': length ?? '',
      'dateAdded': dateAdded ?? '',
      'dateModified': dateModified ?? '',
    };
  }
}
