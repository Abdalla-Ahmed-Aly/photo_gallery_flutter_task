import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/domain/repositories/photo_repository.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/domain/usecases/get_photos_usecase.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/data/model/photo_model/photo_model.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/data/model/photo_model/photo.dart';

class MockPhotoRepository extends Mock implements PhotoRepository {}

void main() {
  late GetPhotosUseCase useCase;
  late MockPhotoRepository mockRepository;

  setUp(() {
    mockRepository = MockPhotoRepository();
    useCase = GetPhotosUseCase(mockRepository, page: 1);
  });

  test('should return PhotoModel from repository', () async {
    final model = PhotoModel(photos: [Photo(id: 1, photographer: 'Ali', src: null)]);

    when(mockRepository.fetchPhotos(page: 1, perPage: 40))
        .thenAnswer((_) async => model);

    final result = await useCase(page: 1);

    expect(result, model);
    verify(mockRepository.fetchPhotos(page: 1, perPage: 40)).called(1);
  });
}
