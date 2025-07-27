import 'package:injectable/injectable.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/data/model/photo_model/photo_model.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/domain/repositories/photo_repository.dart';

@lazySingleton
class GetPhotosUseCase {
  final PhotoRepository repository;

  GetPhotosUseCase(this.repository, {required int page});

  Future<PhotoModel> call({int page = 1, int perPage = 40}) {
    return repository.fetchPhotos(page: page, perPage: perPage);
  }
}
