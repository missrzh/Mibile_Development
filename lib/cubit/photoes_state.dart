part of 'photoes_cubit.dart';

@immutable
abstract class PhotoesState {}

class PhotoesInitial extends PhotoesState {}

class PhotoesLoading extends PhotoesState {}

class PhotoesLoaded extends PhotoesState {
  final List<String> photoes;
  PhotoesLoaded(this.photoes);
}

class PhotoesError extends PhotoesState {
  final String message;
  PhotoesError(this.message);
}
