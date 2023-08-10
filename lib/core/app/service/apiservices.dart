import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:music_app/core/errors/exceptions.dart';
import 'package:music_app/shared/models/genre_detail_model.dart';
import 'package:music_app/shared/models/genre_models.dart';

class ApiServices extends DioForNative {
  ApiServices([super.baseOptions]);

  Future<List<GenreModels>> getGenre() async {
    try {
      const endpoint = '/genres';
      final response = await get(endpoint);
      return (response.data as List)
          .map((genre) => GenreModels.fromMap(genre))
          .toList();
      // ignore: deprecated_member_use
    } on DioError catch (dioerror, stackTrace) {
      log(
        'erro ao fazer get dos generos musicais',
        error: dioerror,
        stackTrace: stackTrace,
      );
      // ignore: deprecated_member_use
      throw ApiExceptions(
        message: 'Erro ao carregar generos',
        statusCode: dioerror.response?.statusCode,
      );
    } catch (error, stackTrace) {
      log(
        "Erro ao fazer o get dos generos ",
        stackTrace: stackTrace,
      );
      throw GeneralExption();
    }
  }

  Future<GenreDetailModel> getdetail({required String genre}) async {
    try {
      final endpoint = "/genres/${genre}";

      final response = await get(endpoint);

      return GenreDetailModel.fromMap(response.data);
      // ignore: deprecated_member_use
    } on DioError catch (dioerror, stackTrace) {
      log(
        'erro ao fazer get dos detalhes musicais',
        error: dioerror,
        stackTrace: stackTrace,
      );
      // ignore: deprecated_member_use
      throw ApiExceptions(
        message: 'Erro ao carregar detalhes',
        statusCode: dioerror.response?.statusCode,
      );
    } catch (error, stackTrace) {
      log(
        "Erro ao fazer o get dos detalhes ",
        stackTrace: stackTrace,
      );
      throw GeneralExption();
    }
  }
}
