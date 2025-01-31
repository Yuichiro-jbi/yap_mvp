import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:math';
import '../../provider/islander_provider.dart';
import '../../provider/lesson_provider.dart';
import '../../router/app_router.dart';
import 'widgets/lesson_card.dart';
import 'widgets/islander_stats_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // スクロール可能なコンテンツ
          Positioned.fill(
            top: 0,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // ヘッダーの高さ分のスペース
                  const SizedBox(height: 40),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Consumer(
                      builder: (context, ref, child) {
                        final lessons = ref.watch(lessonNotifierProvider);
                        final islander = ref.watch(islanderNotifierProvider);

                        return LayoutBuilder(
                          builder: (context, constraints) {
                            const verticalSpacing = 85.0;
                            const amplitude = 50.0;
                            const frequency = 0.3;
                            final centerX = constraints.maxWidth / 2;

                            return Column(
                              children: [
                                ...List.generate(lessons.length, (index) {
                                  final x = centerX + amplitude * sin(index * frequency * pi);

                                  return Container(
                                    height: verticalSpacing,
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: Transform.translate(
                                      offset: Offset(x - centerX, 0),
                                      child: LessonCard(
                                        lesson: lessons[index],
                                        onTap: () {
                                          context.pushNamed(
                                            AppRoute.lesson.name,
                                            pathParameters: {'id': lessons[index].id},
                                            extra: lessons[index],
                                          );
                                        },
                                        isCompleted: islander.completedLessonIds.contains(lessons[index].id),
                                        isLocked: !_canStartLesson(lessons[index].id, islander.completedLessonIds),
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 固定ヘッダー
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Consumer(
                builder: (context, ref, child) {
                  final islander = ref.watch(islanderNotifierProvider);
                  return IslanderStatsHeader(islander: islander);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _canStartLesson(String lessonId, List<String> completedLessonIds) {
    final id = int.parse(lessonId);
    if (id == 1) return true;
    return completedLessonIds.contains('${id - 1}');
  }
}
