abstract class DataState<T> {
  final T? data;
  final dynamic error;

  DataState({this.data, this.error});
}

class DataStateSuccess<T> extends DataState<T> {
  DataStateSuccess(T data) : super(data: data);
}

class DataStateError<T> extends DataState<T> {
  DataStateError(dynamic error) : super(error: error);
}
