import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String? img;
  final double width;
  final double heigth;
  const ImageWidget({
    super.key,
    required this.heigth,
    required this.img,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return img != null
        ? FadeInImage(
            placeholder:
                const AssetImage("assets/images/music_placeholder.png"),
            image: AssetImage(img!))
        : Image.asset(
            "assets/images/music_placeholder.png",
            width: width,
            height: heigth,
            fit: BoxFit.cover,
          );
  }
}
