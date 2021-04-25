import 'dart:convert';

import 'package:flutter/services.dart';

class Movie {
  String title;
  String year;
  String imdbID;
  String type;
  String poster;
  Movie(this.title, this.year, this.imdbID, this.type, this.poster);
  Movie.fromJson(Map<String, dynamic> json)
      : title = json['Title'],
        year = json['Year'],
        imdbID = json['imdbID'],
        type = json['Type'],
        poster = json['Poster'];
}

class MoviesRead {
  Future<List<Movie>> getMovies() async {
    try {
      // Read the file.
      String data = await rootBundle.loadString('assets/MoviesList.txt');
      dynamic jsonMovies = jsonDecode(data);
      List<Movie> movies = [];
      for (dynamic movie in jsonMovies['Search']) {
        movies.add(Movie.fromJson(movie));
      }
      return movies;
    } catch (e) {
      // If encountering an error, return [].
      return [];
    }
  }
}
