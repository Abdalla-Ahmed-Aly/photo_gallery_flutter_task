import 'package:flutter/material.dart';
import 'package:photo_gallery_flutter_task/AppTheam.dart';
import 'package:photo_gallery_flutter_task/photo_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: PhotoListScreen.routName,
      routes: {PhotoListScreen.routName: (_) => PhotoListScreen()},
    theme: AppTheme.lightTheme,
    darkTheme: AppTheme.lightTheme,
    );
  }
}
