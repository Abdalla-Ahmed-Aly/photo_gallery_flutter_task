
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:photo_gallery_flutter_task/core/cashingHive/cashing.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/data/repositories/photo_repository.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/model/photo_model/photo.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/view/presentation/cubit/photo_state.dart';

class PhotoCubit extends Cubit<PhotoState> {
  final PhotoRepository repository;
  final Box<Photo> _cacheBox = Hive.box<Photo>(Cashing.NameBox);

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
    final photoModel = await repository.fetchPhotos(page: page,perPage: 40);
    final newPhotos = photoModel.photos ?? [];

    _allPhotos.addAll(newPhotos);

    final box = await Hive.openBox<Photo>(Cashing.NameBox);
    for (var photo in newPhotos) {
      box.put(photo.id, photo);
    }

    emit(PhotoLoaded(List.from(_allPhotos)));
  } catch (e) {
    emit(PhotoError(e.toString()));
  }
}

  void loadPhotosFromCache() {
    final List<Photo> cached = _cacheBox.values.toList();
    _allPhotos = cached;
print("cash" + _allPhotos.length.toString());
    if (cached.isNotEmpty) {
      emit(PhotoLoaded(List.from(cached)));
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
