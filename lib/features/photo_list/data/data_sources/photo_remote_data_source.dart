import 'package:photo_gallery_flutter_task/core/API%20Service/photo_api_service.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/data/model/photo_model/photo_model.dart';

class PhotoRemoteDataSource {
  final PhotoApiService api;

  PhotoRemoteDataSource(this.api);

  Future<PhotoModel> getPhotos({int page = 1}) {
    return api.getCuratedPhotos(page: page);
  }
}
