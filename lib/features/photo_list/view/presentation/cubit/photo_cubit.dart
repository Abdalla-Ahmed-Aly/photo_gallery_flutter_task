import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/data/model/photo_model/photo.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/domain/repositories/photo_repository.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/domain/usecases/get_photos_usecase.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/view/presentation/cubit/photo_state.dart';

@injectable
class PhotoCubit extends Cubit<PhotoState> {
  final PhotoRepository repository;

  List<Photo> _allPhotos = [];
  bool isOnline = true;
  bool isDark = false;

  PhotoCubit(this.repository) : super(PhotoInitial());

  Future<void> fetchPhotos({int page = 1}) async {
    if (!isOnline) {
      loadPhotosFromCache();
      return;
    }

    try {
      final getPhotosUseCase = GetPhotosUseCase(repository,page: page);
      final photoModel = await getPhotosUseCase.call(page: page);
      final newPhotos = photoModel.photos ?? [];

      _allPhotos.addAll(newPhotos); 

      await repository.cachePhotos(newPhotos); 

      emit(PhotoLoaded(
        List.from(_allPhotos.map((photo) => photo.toEntity()))
      ));
    } catch (e) {
      emit(PhotoError(e.toString()));
    }
  }

  void loadPhotosFromCache() {
    final List<Photo> cached = repository.getCachedPhotos();
    _allPhotos = cached;

    if (cached.isNotEmpty) {
      emit(PhotoLoaded(
        cached.map((photo) => photo.toEntity()).toList()
      ));
    } else {
      emit(PhotoError("لا توجد صور مخزنة حاليًا"));
    }
  }

  void setOnlineStatus(bool status) {
    isOnline = status;
  }

  void toggleDarkMode() {
    isDark = !isDark;
  }
}
