import 'package:photo_gallery_flutter_task/features/photo_list/data/model/photo_model/photo.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/domain/entities/photo_entity.dart';

extension Extension on Photo {
  PhotoEntity toEntity() => PhotoEntity(id: id ?? 0, url: src?.medium ?? '');
  
}
