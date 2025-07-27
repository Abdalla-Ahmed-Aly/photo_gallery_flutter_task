import 'package:injectable/injectable.dart';
import 'package:photo_gallery_flutter_task/core/Theam/ThemeCubit.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/data/repositories/photo_repository_impl.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/view/presentation/cubit/photo_cubit.dart';

@injectable
PhotoCubit photoCubit(PhotoRepositoryImpl repository) => PhotoCubit(repository);

@injectable
ThemeCubit themeCubit() => ThemeCubit();
