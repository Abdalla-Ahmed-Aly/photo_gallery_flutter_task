// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive/hive.dart' as _i979;
import 'package:injectable/injectable.dart' as _i526;
import 'package:photo_gallery_flutter_task/core/API%20Service/photo_api_service.dart'
    as _i441;
import 'package:photo_gallery_flutter_task/core/di/injection_module.dart'
    as _i110;
import 'package:photo_gallery_flutter_task/features/photo_list/data/data_sources/photo_remote_data_source.dart'
    as _i973;
import 'package:photo_gallery_flutter_task/features/photo_list/data/data_sources/PhotoLocalDataSource.dart'
    as _i1063;
import 'package:photo_gallery_flutter_task/features/photo_list/data/model/photo_model/photo.dart'
    as _i354;
import 'package:photo_gallery_flutter_task/features/photo_list/data/repositories/photo_repository_impl.dart'
    as _i373;
import 'package:photo_gallery_flutter_task/features/photo_list/domain/repositories/photo_repository.dart'
    as _i523;
import 'package:photo_gallery_flutter_task/features/photo_list/domain/usecases/get_photos_usecase.dart'
    as _i737;
import 'package:photo_gallery_flutter_task/features/photo_list/view/presentation/cubit/photo_cubit.dart'
    as _i1071;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    await gh.factoryAsync<_i979.Box<_i354.Photo>>(
      () => registerModule.providePhotoBox(),
      instanceName: 'photoBox',
      preResolve: true,
    );
    gh.lazySingleton<_i441.PhotoApiService>(
      () => registerModule.photoApiService(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i1063.PhotoLocalDataSource>(
      () => _i1063.PhotoLocalDataSource(
        gh<_i979.Box<_i354.Photo>>(instanceName: 'photoBox'),
      ),
    );
    gh.lazySingleton<_i973.PhotoRemoteDataSource>(
      () => registerModule.remote(gh<_i441.PhotoApiService>()),
    );
    gh.lazySingleton<_i523.PhotoRepository>(
      () => _i373.PhotoRepositoryImpl(
        gh<_i973.PhotoRemoteDataSource>(),
        gh<_i1063.PhotoLocalDataSource>(),
      ),
    );
    gh.factory<_i1071.PhotoCubit>(
      () => _i1071.PhotoCubit(gh<_i523.PhotoRepository>()),
    );
    gh.lazySingleton<_i737.GetPhotosUseCase>(
      () =>
          _i737.GetPhotosUseCase(gh<_i523.PhotoRepository>(), page: gh<int>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i110.RegisterModule {}
