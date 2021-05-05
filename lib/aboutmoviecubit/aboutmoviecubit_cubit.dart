import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_app1/classes/readjson.dart';

part 'aboutmoviecubit_state.dart';

class AboutmoviecubitCubit extends Cubit<AboutmoviecubitState> {
  final MoviesRead serviceAbout;
  AboutmoviecubitCubit(this.serviceAbout) : super(AboutmoviecubitInitial());
  Future<void> load(String id) async {
    try {
      emit(AboutmoviecubitLoading());
      Movie movie = await serviceAbout.getMovie(id);
      print(movie.actors);
      emit(AboutmoviecubitLoaded(movie));
    } catch (e) {
      emit(AboutmoviecubitError(e.toString()));
    }
  }
}
