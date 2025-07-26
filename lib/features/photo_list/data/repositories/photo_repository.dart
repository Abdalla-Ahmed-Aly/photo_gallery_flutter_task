import 'package:photo_gallery_flutter_task/core/API%20Service/photo_api_service.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/model/photo_model/photo_model.dart';

class PhotoRepository {
  final PhotoApiService api;

  PhotoRepository(this.api);

  Future<PhotoModel> fetchPhotos({int page = 1, int perPage = 40}) {
  return api.getCuratedPhotos(page: page, perPage: perPage);
}
}
