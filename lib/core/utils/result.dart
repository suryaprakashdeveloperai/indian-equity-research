/// Generic Result type to enforce robust error handling without unhandled exceptions
sealed class Result<T> {
  const Result();

  factory Result.success(T data) = Success<T>;
  factory Result.failure(Exception error, [StackTrace? stackTrace]) = Failure<T>;

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  T? get dataOrNull => switch (this) {
        Success(data: final d) => d,
        Failure() => null,
      };

  Exception? get errorOrNull => switch (this) {
        Success() => null,
        Failure(error: final e) => e,
      };

  R fold<R>({
    required R Function(T data) onSuccess,
    required R Function(Exception error) onFailure,
  }) {
    return switch (this) {
      Success(data: final d) => onSuccess(d),
      Failure(error: final e) => onFailure(e),
    };
  }
}

final class Success<T> extends Result<T> {
  const Success(this.data);
  final T data;
}

final class Failure<T> extends Result<T> {
  const Failure(this.error, [this.stackTrace]);
  final Exception error;
  final StackTrace? stackTrace;
}
