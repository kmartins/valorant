import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:valorant/agents/domain/entities/agent.dart';

@immutable
class AgentDto {
  const AgentDto({
    required this.id,
    required this.displayName,
    required this.image,
    required this.backgroundGradientColors,
  });

  factory AgentDto.fromJson(String source) =>
      AgentDto.fromMap(json.decode(source) as Map<String, dynamic>);

  factory AgentDto.fromMap(Map<String, dynamic> map) {
    return AgentDto(
      id: map['uuid'] as String,
      displayName: map['displayName'] as String,
      image: map['fullPortraitV2'] as String,
      backgroundGradientColors:
          List<String>.from(map['backgroundGradientColors'] as List<dynamic>),
    );
  }

  final String id;
  final String displayName;
  final String image;
  final List<String> backgroundGradientColors;

  Agent toEntity() => Agent(
        id: id,
        displayName: displayName,
        image: image,
        backgroundGradientColors: backgroundGradientColors,
      );

  AgentDto copyWith({
    String? id,
    String? displayName,
    String? image,
    List<String>? backgroundGradientColors,
  }) {
    return AgentDto(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      image: image ?? this.image,
      backgroundGradientColors:
          backgroundGradientColors ?? this.backgroundGradientColors,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uuid': id,
      'displayName': displayName,
      'fullPortraitV2': image,
      'backgroundGradientColors': backgroundGradientColors,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'AgentDto(id: $id, displayName: $displayName, image: $image, '
        'backgroundGradientColors: $backgroundGradientColors)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is AgentDto &&
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
}
