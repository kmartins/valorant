import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

@immutable
class Agent {
  const Agent({
    required this.id,
    required this.displayName,
    required this.image,
    required this.backgroundGradientColors,
  });

  final String id;
  final String displayName;
  final String image;
  final List<String> backgroundGradientColors;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Agent &&
        other.id == id &&
        other.displayName == displayName &&
        other.image == image &&
        listEquals(other.backgroundGradientColors, backgroundGradientColors);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        displayName.hashCode ^
        image.hashCode ^
        backgroundGradientColors.hashCode;
  }

  Agent copyWith({
    String? id,
    String? displayName,
    String? image,
    List<String>? backgroundGradientColors,
  }) {
    return Agent(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      image: image ?? this.image,
      backgroundGradientColors:
          backgroundGradientColors ?? this.backgroundGradientColors,
    );
  }
}
