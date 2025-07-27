import 'package:json_annotation/json_annotation.dart';
import 'src.dart';
import '../../../domain/entities/photo_entity.dart'; 

part 'photo.g.dart';

@JsonSerializable()
class Photo {
  int? id;
  int? width;
  int? height;
  String? url;
  String? photographer;
  String? photographerUrl;
  int? photographerId;
  String? avgColor;
  Src? src;
  bool? liked;
  String? alt;

  Photo({
    this.id,
    this.width,
    this.height,
    this.url,
    this.photographer,
    this.photographerUrl,
    this.photographerId,
    this.avgColor,
    this.src,
    this.liked,
    this.alt,
  });

  factory Photo.fromJson(Map<String, dynamic> json) =>
      _$PhotoFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoToJson(this);

  PhotoEntity toEntity() {
    return PhotoEntity(
      id: id ?? 0,
      url: src?.medium ?? '',
    );
  }
}
