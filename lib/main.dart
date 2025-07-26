import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:photo_gallery_flutter_task/core/API%20Service/constans.dart';
import 'package:photo_gallery_flutter_task/core/Theam/ThemeCubit.dart';

import 'core/API Service/photo_api_service.dart';
import 'core/Theam/AppTheam.dart';
import 'features/photo_list/data/repositories/photo_repository.dart';
import 'features/photo_list/view/presentation/cubit/photo_cubit.dart';
import 'features/photo_list/view/presentation/screens/photo_list_screen.dart';

void main() {
  final dio = Dio();

  dio.options.headers = {'Authorization': ApiConstans.apiKey};

  final photoApiService = PhotoApiService(dio);
  final repository = PhotoRepository(photoApiService);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PhotoCubit(repository)..fetchPhotos()),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: PhotoListScreen.routName,
          routes: {PhotoListScreen.routName: (_) => PhotoListScreen()},
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
        );
      },
    );
  }
}
