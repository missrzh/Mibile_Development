import 'dart:typed_data';

import 'package:my_app1/classes/photo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'classes/readjson.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'super_db9.db'),
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE movies (
          Title TEXT,
          Type TEXT,
          Year  TEXT,
          Poster TEXT,
          imdbID TEXT
        );
        ''');
        await db.execute('''
        CREATE TABLE movies_details (
          Title TEXT,
          Type TEXT,
          Year  TEXT,
          Poster TEXT,
          Rated TEXT,
          Released TEXT,
          Runtime TEXT,
          Genre TEXT,
          Director TEXT,
          Writer TEXT,
          Actors TEXT,
          Plot TEXT,
          Language TEXT,
          Country TEXT,
          Awards TEXT,
          imdbRating TEXT,
          imdbVotes TEXT,
          Production TEXT,
          imdbID TEXT
        );
        ''');
        await db.execute('''
        CREATE TABLE gallery (
          url TEXT PRIMARY KEY,
          image BLOB
        );
        ''');
        await db.execute('''
        CREATE TABLE gallery_urls (
          url TEXT PRIMARY KEY
        );
        ''');
      },
      version: 1,
    );
  }

  newMovies(List<Movie> movies) async {
    final db = await database;
    Batch batch = db.batch();
    for (Movie movie in movies) {
      batch.insert(
        'movies',
        {
          'Title': movie.title,
          'Type': movie.type,
          'Year': movie.year,
          'Poster': movie.poster != "N/A" ? movie.poster : '',
          'imdbID': movie.imdbID
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  newMovie(Movie movie) async {
    final db = await database;
    await db.insert(
      "movies_details",
      movie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  newPhotoes(List<String> urls) async {
    final db = await database;
    Batch batch = db.batch();
    for (String url in urls) {
      batch.insert(
        'gallery_urls',
        {'url': url},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  //Future<List<Photo>> retrieveUsers() async {
  //  final Database db = await database;
  //  final List<Map<String, Object>> queryResult = await db.query('photoes');
  //  return queryResult.map((e) => Photo.fromMap(e)).toList();
  //}

  Future<List<String>> getPhotoes() async {
    final db = await database;
    var res = await db.query('gallery_urls');
    return List.generate(res.length, (index) => res[index]['url']);
  }

  Future<List<Movie>> getMovies(String query) async {
    final db = await database;
    var res = await db.query('movies');

    final retu = List.generate(res.length, (index) => Movie.fromMap(res[index]))
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    print(retu);
    return retu;
  }

  Future<Movie> getMovie(String id) async {
    if (id == null) {
      return null;
    }
    final db = await database;
    var res = await db.query(
      'movies_details',
      where: "imdbID = ?",
      whereArgs: [id],
    );
    print(res);
    return res.isNotEmpty ? Movie.fromMap(res.first) : null;
  }
}
//class DatabaseHandler {
//  Future<Database> initializeDB() async {
//    String path = await getDatabasesPath();
//    return openDatabase(
//      join(path, 'example.db'),
//      onCreate: (database, version) async {
//        await database.execute(
//          "CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL,year INTEGER NOT NULL, type TEXT NOT NULL)",
//        );
//      },
//      version: 1,
//    );
//  }
//
//  Future<int> insertUser(List<Photo> photoes) async {
//    int result = 0;
//    final Database db = await initializeDB();
//    for (var photo in photoes) {
//      result = await db.insert('photoes', photo.toMap());
//    }
//    return result;
//  }
//
//  Future<List<Photo>> retrieveUsers() async {
//    final Database db = await initializeDB();
//    final List<Map<String, Object>> queryResult = await db.query('photoes');
//    return queryResult.map((e) => Photo.fromMap(e)).toList();
//  }
//
//  Future<void> deleteUser(int id) async {
//    final db = await initializeDB();
//    await db.delete(
//      'photoes',
//      where: "id = ?",
//      whereArgs: [id],
//    );
//  }
//}
