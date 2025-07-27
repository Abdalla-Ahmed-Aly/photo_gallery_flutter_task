import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/data/model/photo_model/photo.dart';

@lazySingleton
class PhotoLocalDataSource {
  final Box<Photo> _box;

  PhotoLocalDataSource(@Named('photoBox') this._box);

  List<Photo> getCachedPhotos() => _box.values.toList();

  Future<void> cachePhotos(List<Photo> photos) async {
    for (var photo in photos) {
      await _box.put(photo.id, photo);
    }
  }
}
