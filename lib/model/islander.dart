import 'package:freezed_annotation/freezed_annotation.dart';

part 'islander.freezed.dart';
part 'islander.g.dart';

@freezed
class Islander with _$Islander {
  const factory Islander({
    required String id,
    required String name,
    required int experience,
    required int sats,
    required DateTime createdAt,
    @Default([]) List<String> completedLessonIds,
  }) = _Islander;

  factory Islander.fromJson(Map<String, dynamic> json) => _$IslanderFromJson(json);
}
