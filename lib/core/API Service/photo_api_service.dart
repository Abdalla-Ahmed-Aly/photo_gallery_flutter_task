import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:photo_gallery_flutter_task/core/API%20Service/constans.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/model/photo_model/photo_model.dart';

part 'photo_api_service.g.dart';

@RestApi(baseUrl: ApiConstans.BASE_URL)
abstract class PhotoApiService {
  factory PhotoApiService(Dio dio) = _PhotoApiService;

  @GET(ApiConstans.curatedEndpoint)
  Future<PhotoModel> getCuratedPhotos({
    @Query("page") int page = 1,
    @Query("per_page") int perPage = 40,
  });
}
