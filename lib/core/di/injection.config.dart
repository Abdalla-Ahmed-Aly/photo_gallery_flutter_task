// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:photo_gallery_flutter_task/core/API%20Service/photo_api_service.dart'
    as _i6;
import 'package:photo_gallery_flutter_task/core/di/injection_module.dart'
    as _i12;
import 'package:photo_gallery_flutter_task/features/photo_list/data/data_sources/photo_remote_data_source.dart'
    as _i8;
import 'package:photo_gallery_flutter_task/features/photo_list/data/data_sources/PhotoLocalDataSource.dart'
    as _i7;
import 'package:photo_gallery_flutter_task/features/photo_list/data/model/photo_model/photo.dart'
    as _i4;
import 'package:photo_gallery_flutter_task/features/photo_list/data/repositories/photo_repository_impl.dart'
    as _i10;
import 'package:photo_gallery_flutter_task/features/photo_list/domain/repositories/photo_repository.dart'
    as _i9;
import 'package:photo_gallery_flutter_task/features/photo_list/view/presentation/cubit/photo_cubit.dart'
    as _i11;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i3.Box<_i4.Photo>>(
      () => registerModule.providePhotoBox(),
      instanceName: 'photoBox',
      preResolve: true,
    );
    gh.lazySingleton<_i5.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i6.PhotoApiService>(
        () => registerModule.photoApiService(gh<_i5.Dio>()));
    gh.lazySingleton<_i7.PhotoLocalDataSource>(() => _i7.PhotoLocalDataSource(
        gh<_i3.Box<_i4.Photo>>(instanceName: 'photoBox')));
    gh.lazySingleton<_i8.PhotoRemoteDataSource>(
        () => registerModule.remote(gh<_i6.PhotoApiService>()));
    gh.lazySingleton<_i9.PhotoRepository>(() => _i10.PhotoRepositoryImpl(
          gh<_i8.PhotoRemoteDataSource>(),
          gh<_i7.PhotoLocalDataSource>(),
        ));
    gh.factory<_i11.PhotoCubit>(
        () => _i11.PhotoCubit(gh<_i9.PhotoRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i12.RegisterModule {}
