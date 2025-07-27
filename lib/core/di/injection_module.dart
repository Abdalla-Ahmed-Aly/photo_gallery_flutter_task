import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_gallery_flutter_task/core/API%20Service/constans.dart';
import 'package:photo_gallery_flutter_task/core/API%20Service/photo_api_service.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/data/data_sources/photo_remote_data_source.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/data/model/photo_model/photo.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => Dio()..options.headers = {'Authorization': ApiConstans.apiKey};

  @lazySingleton
  PhotoApiService photoApiService(Dio dio) => PhotoApiService(dio);

  @lazySingleton
  PhotoRemoteDataSource remote(PhotoApiService api) =>
      PhotoRemoteDataSource(api);

  // @lazySingleton
  // PhotoLocalDataSource local() {
  //   final box = Hive.box<Photo>('photoBox');
  //   return PhotoLocalDataSource(box);
  // }

  @preResolve
  @Named('photoBox')
  Future<Box<Photo>> providePhotoBox() async {
    return await Hive.openBox<Photo>('photoBox');
  }
}
