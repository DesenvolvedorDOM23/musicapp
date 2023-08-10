import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/core/app/music_app_colors.dart';
import 'package:music_app/features/genre_details/presentation/bidings/genre_detail_bidings.dart';
import 'package:music_app/features/genre_details/presentation/screens/genre_details_screen.dart';
import 'package:music_app/features/genre_list/presentation/bidings/genrelist_bidings.dart';
import 'package:music_app/features/genre_list/presentation/screens/genre_list_screen.dart';

class MusicAppMaterial {
  MusicAppMaterial._();

  static String get getTitle => "MusicApp";

  static List<GetPage> get getPage => [
        GetPage(
            name: GenreListScreen.routName,
            page: () => const GenreListScreen(),
            binding: GenrelistBidings(),
            children: [
              GetPage(
                name: GenreDetailsScreen.routName,
                page: () => const GenreDetailsScreen(),
                binding: GenreDetailBidings(),
              )
            ])
      ];
  static ThemeData get getTheme => ThemeData(
        primaryColor: MusicAppColors.primaryColor,
        appBarTheme: AppBarTheme(
          backgroundColor: MusicAppColors.primaryColor,
          titleTextStyle: TextStyle(
            color: MusicAppColors.secundaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
          centerTitle: true,
          elevation: 0,
        ),
        fontFamily: 'Nunito',
      );
}
