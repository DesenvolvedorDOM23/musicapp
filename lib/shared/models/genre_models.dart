class GenreModels {
  final String? img;
  final String title;
  final String searchString;

  GenreModels({
    this.img,
    required this.title,
    required this.searchString,
  });
  factory GenreModels.fromMap(Map<String, dynamic> map) {
    return GenreModels(
      img: map['img'],
      title: map['title'] ?? '',
      searchString: map['searchString'] ?? '',
    );
  }
}
