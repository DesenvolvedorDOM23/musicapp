import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:music_app/core/app/music_app.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MusicApp());
}



  // This widget is the root of your application.



