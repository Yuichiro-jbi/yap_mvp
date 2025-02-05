import 'package:flutter/material.dart';
import 'package:flutter/services.dart';  // SystemUiOverlayStyleのために追加
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        scrolledUnderElevation: 0,
        elevation: 0,
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).colorScheme.surface,
          statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark,
          statusBarBrightness: Theme.of(context).brightness == Brightness.dark
              ? Brightness.dark
              : Brightness.light,
        ),
        flexibleSpace: Column(
          children: [
            Expanded(
              child: SafeArea(
                bottom: false,
                child: Consumer(
                  builder: (context, ref, child) {
                    final islander = ref.watch(islanderNotifierProvider);
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: IslanderStatsHeader(islander: islander),
                    );
                  },
                ),
              ),
            ),
            Container(
              height: 1,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white.withOpacity(0.1)
                  : Theme.of(context).colorScheme.outlineVariant,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(
          color: Theme.of(context).colorScheme.surface,
          child: Column(
            children: [
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
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Positioned(
                                      left: x - 35, // カードの幅の半分（70/2）を引く
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
                                  ],
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
    );
  }

  bool _canStartLesson(String lessonId, List<String> completedLessonIds) {
    if (lessonId == '1') return true;
    final lessonNumber = int.parse(lessonId);
    final previousLessonId = '${lessonNumber - 1}';
    return completedLessonIds.contains(previousLessonId);
  }
}
