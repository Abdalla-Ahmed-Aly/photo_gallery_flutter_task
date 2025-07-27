import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/data/model/Adapter/photo_Adapter.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/data/model/photo_model/photo.dart';
import 'package:photo_gallery_flutter_task/core/cashingHive/cashing.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@injectableInit
Future<void> configureDependencies() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PhotoAdapter());

  await Hive.openBox<Photo>(Cashing.NameBox);

  await getIt.init();
}
