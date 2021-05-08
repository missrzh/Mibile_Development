import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app1/aboutmovie.dart';
import 'package:my_app1/addmovie.dart';
import 'package:my_app1/moviereadlistcubit/movieslistcubit_cubit.dart';
import 'package:my_app1/classes/readjson.dart';
import 'package:my_app1/widgets/searchwidget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
      body: Column(children: [
        buildSearch(),
        BlocProvider(
          create: (context) => myCubit,
          child: BlocBuilder(
            cubit: myCubit,
            builder: (BuildContext context, state) {
              if (state is MovieslistcubitInitial) {
                myCubit.load(query);
              }
              if (state is MovieslistcubitLoading) {
                final spinkit = SpinKitRotatingCircle(
                  color: Colors.blue,
                  size: 50.0,
                );
                return Center(child: spinkit);
              }
              if (state is MovieslistcubitLoaded) {
                allMovies = state.movies;

                return buildLoaded(allMovies, context);
              }
              return Container();
            },
          ),
        ),
      ]),
    );
  }

  Widget buildLoaded(List<Movie> movies, BuildContext contex) {
    return Expanded(
      child: movies.length == 0 || query.length < 3
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
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(movie.title + " Deleted")));
                  },
                  child: ListTile(
                      leading: movies[index].poster == "" ||
                              movies[index].poster == null ||
                              movies[index].poster == 'N/A'
                          ? Image.asset('img/empty1.png')
                          : Image.network(movies[index].poster),
                      title: Text(
                        movies[index].title,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                      subtitle:
                          Text(movies[index].year + '\n' + movies[index].type),
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
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Title',
        onChanged: searchMovie,
      );

  void searchMovie(String query) async {
    myCubit.load(query);
    setState(() {
      this.query = query;
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
