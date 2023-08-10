abstract class Failure {}

class GetGenreListFailure extends Failure {
  final String message;
  GetGenreListFailure(this.message);
}

class GetGenreDetailFailure extends Failure {
  final String message;
  GetGenreDetailFailure(this.message);
}
