import 'package:path/path.dart';
import 'package:quote_mobile_app/repository/localdb/tables/favourite_quote.dart';
import 'package:sqflite/sqflite.dart';

class DBManager {
  Database? _database;
  String sqliteDbName = 'quote_mobile_app.db';
  final String _tableName = 'favouritequotes';

  Future openDb() async {
    _database = await openDatabase(join(await getDatabasesPath(), sqliteDbName),
        onCreate: (Database db, int version) {
      return db.execute(
        'CREATE TABLE $_tableName(id TEXT PRIMARY KEY, name TEXT, content TEXT, author TEXT, length INTEGER, dateAdded TEXT, dateModified TEXT)',
      );
    }, version: 1);
    return _database;
  }

  Future insertQuote(FavouriteQuote quote) async {
    await openDb();

    await _database?.insert(
      _tableName,
      quote.toJson(),
    );
  }

  Future<List<FavouriteQuote>?> fetchQuotes(
      String searchKey, String column) async {
    await openDb();

    List<Map<String, dynamic>> quotes = [];

    if (searchKey.isEmpty) {
      quotes = await _database?.query(_tableName) ?? [];
    } else {
      quotes = await _database?.query(
            _tableName,
            where: '$column LIKE ?',
            whereArgs: ['%$searchKey%'],
          ) ??
          [];
    }

    return List.generate(
      quotes.length,
      (i) {
        return FavouriteQuote(
          id: quotes[i]['id'],
          content: quotes[i]['content'],
          author: quotes[i]['author'],
          length: quotes[i]['length'],
          dateAdded: quotes[i]['dateAdded'],
          dateModified: quotes[i]['dateModified'],
        );
      },
    );
  }

  Future<void> updateQuote(FavouriteQuote quote) async {
    await openDb();

    await _database?.update(
      _tableName,
      quote.toJson(),
      where: 'id = ?',
      whereArgs: [quote.id ?? ''],
    );
  }

  Future<void> deleteQuote(FavouriteQuote quote) async {
    await openDb();

    await _database?.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [quote.id ?? ''],
    );
  }

  Future<void> deleteAllQuotes() async {
    await openDb();

    await _database?.rawDelete('DELETE FROM $_tableName');
  }
}
