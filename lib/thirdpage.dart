import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app1/aboutmovie.dart';
import 'package:my_app1/addmovie.dart';
import 'package:my_app1/moviereadlistcubit/movieslistcubit_cubit.dart';
import 'package:my_app1/classes/readjson.dart';
import 'package:my_app1/widgets/searchwidget.dart';

class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  final MovieslistcubitCubit myCubit = MovieslistcubitCubit(MoviesRead());
  String query = "";
  List<Movie> filteredMovies;
  List<Movie> allMovies;

  var id = 0;
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => myCubit,
      child: BlocBuilder(
        cubit: myCubit,
        builder: (BuildContext context, state) {
          if (state is MovieslistcubitInitial) {
            myCubit.load();
          }
          if (state is MovieslistcubitLoading) {
            return Text("Loading ...");
          }
          if (state is MovieslistcubitLoaded) {
            query.isEmpty
                ? allMovies = state.movies
                : allMovies = filteredMovies;
            return buildLoaded(allMovies, context);
          }
          return Container();
        },
      ),
    );
  }

  Widget buildLoaded(List<Movie> movies, BuildContext contex) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                navigateSecondPage(MoviesRead());
              })
        ],
        title: Text("Movies"),
      ),
      body: Column(
        children: [
          buildSearch(),
          Expanded(
            child: movies.length == 0
                ? Center(child: Text("No Results"))
                : ListView.builder(
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      return Dismissible(
                        key: Key(movie.title),
                        // Provide a function that tells the app
                        // what to do after an item has been swiped away.
                        onDismissed: (direction) {
                          // Remove the item from the data source.
                          setState(() {
                            movies.removeAt(index);
                          });

                          // Then show a snackbar.
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(movie.title + " Deleted")));
                        },
                        child: ListTile(
                            leading: movies[index].poster == ""
                                ? Image.asset('img/empty1.png')
                                : Image.asset('img/' + movies[index].poster),
                            title: Text(
                              movies[index].title,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                            subtitle: Text(
                                movies[index].year + '\n' + movies[index].type),
                            isThreeLine: true,
                            onTap: () {
                              movies[index].imdbID == "noid" ||
                                      movies[index].imdbID == null
                                  ? print("no")
                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AboutMovie(movies[index].imdbID)),
                                    );
                            }),
                      );
                    }),
          ),
        ],
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Title',
        onChanged: searchMovie,
      );

  void searchMovie(String query) {
    final movies = allMovies.where((movie) {
      final titleLower = movie.title.toLowerCase();
      final authorLower = movie.year.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          authorLower.contains(searchLower);
    }).toList();
    setState(() {
      this.query = query;
      this.filteredMovies = movies;
    });
  }

  void refreshData() {
    id++;
  }

  Future onGoBack(dynamic value) {
    refreshData();
    setState(() {});
  }

  void navigateSecondPage(service) {
    Route route = MaterialPageRoute(builder: (context) => AddMovie(service));
    Navigator.push(context, route).then(onGoBack);
  }
}
