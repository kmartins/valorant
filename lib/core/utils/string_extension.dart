import 'package:flutter/widgets.dart';

extension StringExtension on String {
  Color toColor() => Color(int.parse('FF${replaceAll('ff', '')}', radix: 16));
}
