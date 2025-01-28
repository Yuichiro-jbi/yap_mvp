import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../provider/islander_provider.dart';
import '../../provider/lesson_provider.dart';
import '../../router/app_router.dart';
import 'widgets/islander_stats_header.dart';
import 'widgets/lesson_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Consumer(
            builder: (context, ref, child) {
              final islander = ref.watch(islanderNotifierProvider);
              return IslanderStatsHeader(islander: islander);
            },
          ),
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final lessons = ref.watch(lessonNotifierProvider);
                final islander = ref.watch(islanderNotifierProvider);
                
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  itemCount: lessons.length,
                  itemBuilder: (context, index) {
                    final lesson = lessons[index];
                    final isCompleted = islander.completedLessonIds.contains(lesson.id);
                    // 前のレッスンが完了していて、かつレッスンが最初のレッスンでない場合
                    final canStart = index == 0 ||
                        islander.completedLessonIds.contains(
                          lessons[index - 1].id
                        );

                    return LessonCard(
                      lesson: lesson,
                      isCompleted: isCompleted,
                      isAvailable: canStart,
                      onTap: canStart ? () {
                        GoRouter.of(context).pushNamed(
                          AppRoute.lesson.name,
                          pathParameters: {'id': lesson.id},
                          extra: lesson,
                        );
                      } : null,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
