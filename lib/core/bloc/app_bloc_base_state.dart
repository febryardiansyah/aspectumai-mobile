import 'package:equatable/equatable.dart';

/// Base class for bloc states with loading, data, and error states
///
/// This class provides a standardized way to handle state management
/// across the application with common states for loading, success, and error.
abstract class AppBlocBaseState<T> extends Equatable {
  final T? data;
  final String? errorMessage;
  final AppBlocBaseStateType type;

  const AppBlocBaseState({
    this.data,
    this.errorMessage,
    this.type = AppBlocBaseStateType.initial,
  });

  AppBlocBaseState<T> copyWith({
    AppBlocBaseStateType? type,
    T? data,
    String? errorMessage,
  });

  bool get isInitial => type == AppBlocBaseStateType.initial;
  bool get isLoading => type == AppBlocBaseStateType.loading;
  bool get isSuccess => type == AppBlocBaseStateType.success;
  bool get isError => type == AppBlocBaseStateType.error;

  @override
  List<Object?> get props => [type, data, errorMessage];
}

enum AppBlocBaseStateType {
  initial,
  loading,
  success,
  error,
}