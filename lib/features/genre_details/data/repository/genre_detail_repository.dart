import 'package:dartz/dartz.dart';
import 'package:music_app/core/app/service/apiservices.dart';
import 'package:music_app/core/errors/exceptions.dart';
import 'package:music_app/core/errors/failure.dart';
import 'package:music_app/shared/models/genre_detail_model.dart';

class GenreDetailRepository {
  final ApiServices _apiServices;
  GenreDetailRepository({required ApiServices apiServices})
      : _apiServices = apiServices;

  Future<Either<Failure, GenreDetailModel>> getGenreDetail(String genre) async {
    try {
      final genreDetails = await _apiServices.getdetail(genre: genre);
      return Right(genreDetails);
    } on ApiExceptions catch (apiException) {
      return Left(GetGenreDetailFailure(apiException.message));
    } on GeneralExption catch (generalException) {
      return left(GetGenreDetailFailure(generalException.message));
    }
  }
}
