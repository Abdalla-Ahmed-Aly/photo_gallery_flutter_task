import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery_flutter_task/core/Theam/ThemeCubit.dart';
import 'package:photo_gallery_flutter_task/core/di/injection.dart';

import 'core/Theam/AppTheam.dart';
import 'features/photo_list/view/presentation/cubit/photo_cubit.dart';
import 'features/photo_list/view/presentation/screens/photo_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<PhotoCubit>()),
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
