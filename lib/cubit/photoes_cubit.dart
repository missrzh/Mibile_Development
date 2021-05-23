import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_app1/classes/photo.dart';

part 'photoes_state.dart';

class PhotoesCubit extends Cubit<PhotoesState> {
  final PhotoService service;
  PhotoesCubit(this.service) : super(PhotoesInitial());
  Future<void> load() async {
    try {
      emit(PhotoesLoading());
      List<String> photoes = await service.getPhotoes();
      emit(PhotoesLoaded(photoes));
    } catch (e) {
      emit(PhotoesError(e.toString()));
    }
  }
}
