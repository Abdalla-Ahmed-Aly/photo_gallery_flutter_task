import 'package:json_annotation/json_annotation.dart';
import 'photo.dart';

part 'photo_model.g.dart';

@JsonSerializable()
class PhotoModel {
  int? page;
  int? perPage;
  List<Photo>? photos;
  int? totalResults;
  String? nextPage;
  String? prevPage;

  PhotoModel({
    this.page,
    this.perPage,
    this.photos,
    this.totalResults,
    this.nextPage,
    this.prevPage,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) =>
      _$PhotoModelFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoModelToJson(this);
}
