// photo_remote_data_source.dart
import 'package:photo_gallery_flutter_task/core/API%20Service/photo_api_service.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/model/photo_model/photo_model.dart';

class PhotoRemoteDataSource {
  final PhotoApiService api;

  PhotoRemoteDataSource(this.api);

  Future<PhotoModel> getCuratedPhotos({int page = 1}) =>
      api.getCuratedPhotos(page: page);
}
