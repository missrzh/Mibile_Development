import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_app1/classes/readjson.dart';

part 'movieslistcubit_state.dart';

class MovieslistcubitCubit extends Cubit<MovieslistcubitState> {
  final MoviesRead service;
  MovieslistcubitCubit(this.service) : super(MovieslistcubitInitial());
  Future<void> load(String q) async {
    try {
      emit(MovieslistcubitLoading());
      List<Movie> movieslist = await service.getMovies(q);
      emit(MovieslistcubitLoaded(movieslist));
    } catch (e) {
      emit(MovieslistcubitError(e.toString()));
    }
  }
}
