import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/lesson.dart';

class LessonData {
  final SupabaseClient _supabase;

  LessonData(this._supabase);

  Future<List<Lesson>> getLessons() async {
    try {
      final lessonsResponse = await _supabase
          .from('lessons')
          .select()
          .order('lesson_number', ascending: true);

      final List<Lesson> lessons = [];
      for (final lessonData in lessonsResponse) {
        final questionsResponse = await _supabase
            .from('questions')
            .select()
            .eq('lesson_id', lessonData['id'])
            .order('question_number', ascending: true);

        final questions = questionsResponse.map((q) {
          return Question(
            id: q['id'].toString(),
            text: q['text'],
            options: List<String>.from(q['options']),
            correctIndex: q['correct_index'],
          );
        }).toList();

        final Map<String, String> explanations = {
          for (var q in questionsResponse)
            q['id'].toString(): q['explanation'] as String,
        };

        lessons.add(Lesson(
          id: lessonData['id'].toString(),
          lessonNumber: lessonData['lesson_number'],
          title: lessonData['title'],
          description: lessonData['description'],
          exp: lessonData['exp'],
          questions: questions,
          explanations: explanations,
        ));
      }

      return lessons;
    } catch (e) {
      throw Exception('レッスンの取得に失敗しました: $e');
    }
  }

  Future<Lesson?> getLesson(int lessonNumber) async {
    try {
      final lessonResponse = await _supabase
          .from('lessons')
          .select()
          .eq('lesson_number', lessonNumber)
          .single();

      final questionsResponse = await _supabase
          .from('questions')
          .select()
          .eq('lesson_id', lessonResponse['id'])
          .order('question_number', ascending: true);

      final questions = questionsResponse.map((q) {
        return Question(
          id: q['id'].toString(),
          text: q['text'],
          options: List<String>.from(q['options']),
          correctIndex: q['correct_index'],
        );
      }).toList();

      final Map<String, String> explanations = {
        for (var q in questionsResponse)
          q['id'].toString(): q['explanation'] as String,
      };

      return Lesson(
        id: lessonResponse['id'].toString(),
        lessonNumber: lessonResponse['lesson_number'],
        title: lessonResponse['title'],
        description: lessonResponse['description'],
        exp: lessonResponse['exp'],
        questions: questions,
        explanations: explanations,
      );
    } catch (e) {
      return null;
    }
  }
}
