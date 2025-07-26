import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/data/repositories/photo_repository.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/model/photo_model/photo.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/view/presentation/cubit/photo_state.dart';

class PhotoCubit extends Cubit<PhotoState> {
  final PhotoRepository repository;

  List<Photo> _allPhotos = [];
  bool isDark=false;

  PhotoCubit(this.repository) : super(PhotoInitial());

  Future<void> fetchPhotos({int page = 1}) async {
    if (page == 1) emit(PhotoLoading());

    try {
      final photoModel = await repository.fetchPhotos(page: page);
      _allPhotos.addAll(photoModel.photos ?? []);
      emit(PhotoLoaded(List.from(_allPhotos))); 
    } catch (e) {
      emit(PhotoError(e.toString()));
    }
  }
 void toggleDarkMode() {
  isDark = !isDark;
}
}
