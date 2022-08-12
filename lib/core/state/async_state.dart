import 'package:flutter/foundation.dart';

@immutable
abstract class AsyncState<T> {
  const AsyncState._();
  const factory AsyncState.loading() = AsyncLoading<T>._;
  const factory AsyncState.success(T result) = AsyncData<T>._;
}

class AsyncLoading<T> extends AsyncState<T> {
  const AsyncLoading._() : super._();
}

class AsyncData<T> extends AsyncState<T> {
  const AsyncData._(this.result) : super._();

  final T result;
}
