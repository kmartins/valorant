import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:valorant/core/utils/string_extension.dart';

void main() {
  group('StringExtension', () {
    test('deve converter uma string em uma cor válida', () {
      const value1 = 'b1414cff';
      const value2 = '5589bdff';
      expect(value1.toColor(), const Color(0xffb1414c));
      expect(value2.toColor(), const Color(0xff5589bd));
    });
  });
}
