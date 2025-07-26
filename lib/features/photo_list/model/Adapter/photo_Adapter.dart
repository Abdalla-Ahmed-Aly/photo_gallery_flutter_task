import 'package:hive/hive.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/model/photo_model/photo.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/model/photo_model/src.dart';

class PhotoAdapter extends TypeAdapter<Photo> {
  @override
  final int typeId = 1;

  @override
  Photo read(BinaryReader reader) {
    return Photo(
      id: reader.read(),
      width: reader.read(),
      height: reader.read(),
      url: reader.read(),
      photographer: reader.read(),
      photographerUrl: reader.read(),
      photographerId: reader.read(),
      avgColor: reader.read(),
      liked: reader.read(),
      alt: reader.read(),
      src: Src(
        original: reader.read(),
        large2x: reader.read(),
        large: reader.read(),
        medium: reader.read(),
        small: reader.read(),
        portrait: reader.read(),
        landscape: reader.read(),
        tiny: reader.read(),
      ),
    );
  }

  @override
  void write(BinaryWriter writer, Photo obj) {
    writer.write(obj.id);
    writer.write(obj.width);
    writer.write(obj.height);
    writer.write(obj.url);
    writer.write(obj.photographer);
    writer.write(obj.photographerUrl);
    writer.write(obj.photographerId);
    writer.write(obj.avgColor);
    writer.write(obj.liked);
    writer.write(obj.alt);
    writer.write(obj.src?.original);
    writer.write(obj.src?.large2x);
    writer.write(obj.src?.large);
    writer.write(obj.src?.medium);
    writer.write(obj.src?.small);
    writer.write(obj.src?.portrait);
    writer.write(obj.src?.landscape);
    writer.write(obj.src?.tiny);
  }
}
