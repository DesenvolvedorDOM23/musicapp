import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/core/app/music_app_Initialbidings.dart';
import 'package:music_app/core/app/music_app_material.dart';
import 'package:music_app/features/genre_list/presentation/screens/genre_list_screen.dart';

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: MusicAppMaterial.getTitle,
      theme: MusicAppMaterial.getTheme,
      getPages: MusicAppMaterial.getPage,
      initialRoute: GenreListScreen.routName,
      initialBinding: MusicAppInitialBidings(),
    );
  }
}
