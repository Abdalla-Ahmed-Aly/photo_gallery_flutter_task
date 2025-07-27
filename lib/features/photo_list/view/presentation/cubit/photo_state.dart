import 'package:photo_gallery_flutter_task/features/photo_list/domain/entities/photo_entity.dart';

abstract class PhotoState {}

class PhotoInitial extends PhotoState {}

class PhotoLoading extends PhotoState {}

class PhotoLoaded extends PhotoState {
  final List<PhotoEntity> photos;

  PhotoLoaded(this.photos);
}

class PhotoError extends PhotoState {
  final String message;
  PhotoError(this.message);
}
