import 'package:freezed_annotation/freezed_annotation.dart';

part 'question.freezed.dart';
part 'question.g.dart';

enum QuestionType {
  multipleChoice,  // 4択問題
  trueFalse,      // 丸バツ問題
}

@freezed
class Question with _$Question {
  const factory Question({
    required String id,
    required String question,
    required QuestionType type,
    required List<String> options,
    required int correctAnswerIndex,
    required String explanation,
  }) = _Question;

  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);
}
