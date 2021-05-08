import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_app1/classes/photo.dart';

part 'photoes_state.dart';

class PhotoesCubit extends Cubit<PhotoesState> {
  final PhotoesRead service;
  PhotoesCubit(this.service) : super(PhotoesInitial());
  Future<void> load() async {
    try {
      emit(PhotoesLoading());
      List<Photo> photoes = await service.getPhotoes();
      print('get here');
      emit(PhotoesLoaded(photoes));
    } catch (e) {
      emit(PhotoesError(e));
    }
  }
}
