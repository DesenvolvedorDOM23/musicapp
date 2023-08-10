import 'package:dartz/dartz.dart';
import 'package:music_app/core/app/service/apiservices.dart';
import 'package:music_app/core/errors/exceptions.dart';
import 'package:music_app/shared/models/genre_models.dart';

import '../../../../core/errors/failure.dart';

class GenreListRepository {
  final ApiServices _apiServices;
  GenreListRepository({required ApiServices apiServices})
      : _apiServices = apiServices;

  Future<Either<Failure, List<GenreModels>>> getGenreList() async {
    try {
      final genres = await _apiServices.getGenre();
      return Right(genres);
    } on ApiExceptions catch (apiExption) {
      return Left(GetGenreListFailure(apiExption.message));
    } on GeneralExption catch (generalExption) {
      return left(GetGenreListFailure(generalExption.message));
    }
  }
}
