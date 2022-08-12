import 'package:flutter/foundation.dart';

abstract class BaseViewModel<T extends Object> extends ValueNotifier<T> {
  BaseViewModel(super.value);

  @override
  @protected
  set value(T newValue) => super.value = newValue;
}
