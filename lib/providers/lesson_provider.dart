import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/lesson_data.dart';
import '../models/lesson.dart';

final lessonDataProvider = Provider<LessonData>((ref) {
  final supabase = Supabase.instance.client;
  return LessonData(supabase);
});

final lessonProvider = StateNotifierProvider<LessonNotifier, AsyncValue<List<Lesson>>>((ref) {
  final lessonData = ref.watch(lessonDataProvider);
  return LessonNotifier(lessonData);
});

class LessonNotifier extends StateNotifier<AsyncValue<List<Lesson>>> {
  final LessonData _lessonData;

  LessonNotifier(this._lessonData) : super(const AsyncValue.loading()) {
    loadLessons();
  }

  Future<void> loadLessons() async {
    try {
      state = const AsyncValue.loading();
      final lessons = await _lessonData.getLessons();
      state = AsyncValue.data(lessons);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  List<Lesson> getAllLessons() {
    final currentState = state;
    if (currentState is AsyncData<List<Lesson>>) {
      return currentState.value;
    }
    return [];
  }

  bool isLessonUnlocked(int lessonNumber, int learningProgress) {
    return lessonNumber <= learningProgress + 1;
  }
}
