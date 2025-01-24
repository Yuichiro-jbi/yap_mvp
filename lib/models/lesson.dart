class Question {
  final String id;
  final String text;
  final List<String> options;
  final int correctIndex;

  const Question({
    required this.id,
    required this.text,
    required this.options,
    required this.correctIndex,
  });
}

class Lesson {
  final String id;
  final int lessonNumber;
  final String title;
  final String description;
  final List<Question> questions;
  final Map<String, String> explanations;
  final int exp; // 追加：レッスン完了時に得られるEXP

  const Lesson({
    required this.id,
    required this.lessonNumber,
    required this.title,
    required this.description,
    required this.questions,
    required this.explanations,
    required this.exp, // 追加
  });

  Lesson copyWith({
    String? id,
    int? lessonNumber,
    String? title,
    String? description,
    List<Question>? questions,
    Map<String, String>? explanations,
    int? exp, // 追加
  }) {
    return Lesson(
      id: id ?? this.id,
      lessonNumber: lessonNumber ?? this.lessonNumber,
      title: title ?? this.title,
      description: description ?? this.description,
      questions: questions ?? this.questions,
      explanations: explanations ?? this.explanations,
      exp: exp ?? this.exp, // 追加
    );
  }
}
