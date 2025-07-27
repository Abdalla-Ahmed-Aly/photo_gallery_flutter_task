import 'package:injectable/injectable.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/data/data_sources/PhotoLocalDataSource.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/data/data_sources/photo_remote_data_source.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/data/model/photo_model/photo.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/data/model/photo_model/photo_model.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/domain/repositories/photo_repository.dart';

@LazySingleton(as: PhotoRepository)
class PhotoRepositoryImpl implements PhotoRepository {
  final PhotoRemoteDataSource remote;
  final PhotoLocalDataSource local;

  PhotoRepositoryImpl(this.remote, this.local);

  @override
  Future<PhotoModel> fetchPhotos({int page = 1, int perPage = 40}) {
    return remote.getPhotos(page: page);
  }

  @override
  Future<void> cachePhotos(List<Photo> photos) => local.cachePhotos(photos);

  @override
  List<Photo> getCachedPhotos() => local.getCachedPhotos();
}
