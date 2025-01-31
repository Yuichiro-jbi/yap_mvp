import 'package:freezed_annotation/freezed_annotation.dart';
import 'question.dart';

part 'lesson.freezed.dart';
part 'lesson.g.dart';

@freezed
class Lesson with _$Lesson {
  const factory Lesson({
    required String id,
    required String title,
    required String description,
    required List<Question> questions,
    required int experienceReward,
    required int coinReward,
    @Default(false) bool isCompleted,
  }) = _Lesson;

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);
}
