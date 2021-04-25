import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app1/cubit/movieslistcubit_cubit.dart';
import 'package:my_app1/readjson.dart';

class ThirdPage extends StatelessWidget {
  final MovieslistcubitCubit myCubit = MovieslistcubitCubit(MoviesRead());
  @override
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
            return buildLoaded(state.movies);
          }
          return Container();
        },
      ),
    );
  }

  Widget buildLoaded(List<Movie> movies) {
    return ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: movies[index].poster == ""
                ? Image.asset('img/empty1.png')
                : Image.asset('img/' + movies[index].poster),
            title: Text(
              movies[index].title,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
            subtitle: Text(movies[index].type +
                ' ' +
                movies[index].year +
                '\nimdbID: ' +
                movies[index].imdbID),
            isThreeLine: true,
          );
        });
  }
}
