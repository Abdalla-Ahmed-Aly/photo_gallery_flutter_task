// features/photo_list/domain/repositories/photo_repository.dart
import 'package:photo_gallery_flutter_task/features/photo_list/data/model/photo_model/photo.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/data/model/photo_model/photo_model.dart';

abstract class PhotoRepository {
  Future<PhotoModel> fetchPhotos({int page = 1, int perPage = 40});
  Future<void> cachePhotos(List<Photo> photos);
  List<Photo> getCachedPhotos();
}
