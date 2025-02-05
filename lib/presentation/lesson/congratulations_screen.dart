import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../model/lesson.dart';
import '../../provider/islander_provider.dart';
import '../../provider/lesson_provider.dart';
import '../../provider/lesson_state_provider.dart';
import '../../router/app_router.dart';
import '../home/home_screen.dart';

class CongratulationsScreen extends StatelessWidget {
  final Lesson lesson;
  final List<int> answers;
  final bool isAllCorrect;

  const CongratulationsScreen({
    super.key,
    required this.lesson,
    required this.answers,
    required this.isAllCorrect,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          // 初回クリアかどうかを先に判定
          final islander = ref.read(islanderNotifierProvider);
          final isFirstComplete = !islander.completedLessonIds.contains(lesson.id);

          // 全問正解の場合のみ報酬を付与
          if (isAllCorrect) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final islanderNotifier = ref.read(islanderNotifierProvider.notifier);
              // レッスンが未完了の場合のみ報酬を付与
              if (isFirstComplete) {
                islanderNotifier.completeLesson(
                  lesson.id,
                  lesson.experienceReward,
                  lesson.coinReward,
                );
              }
            });
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isAllCorrect ? Icons.celebration : Icons.school,
                  size: 100,
                  color: isAllCorrect ? Colors.amber : Colors.blue,
                ),
                const SizedBox(height: 24),
                Text(
                  isAllCorrect ? 'おめでとう！' : 'お疲れさま！',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                Text(
                  isAllCorrect ? 'レッスンをクリアしました！' : 'レッスンを終了しました',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                if (!isAllCorrect) ...[
                  const SizedBox(height: 16),
                  Text(
                    '正解数: ${ref.read(lessonNotifierProvider.notifier).countCorrectAnswers(lesson.id, Map.fromIterables(
                      lesson.questions.map((q) => q.id),
                      answers,
                    ))} / ${lesson.questions.length}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'もう一度チャレンジして\n全問正解を目指してみましょう！',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
                if (isAllCorrect) ...[
                  const SizedBox(height: 32),
                  if (isFirstComplete) Column(
                    children: [
                      _RewardItem(
                        icon: Icons.stars,
                        value: lesson.experienceReward.toString(),
                        label: '経験値',
                      ),
                      const SizedBox(height: 16),
                      _RewardItem(
                        icon: Icons.currency_bitcoin,
                        value: lesson.coinReward.toString(),
                        label: 'Sats',
                      ),
                    ],
                  ) else const Text(
                    '既にクリア済みのレッスンです',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ],
                const SizedBox(height: 48),
                FilledButton(
                  onPressed: () {
                    GoRouter.of(context).go('/');
                  },
                  child: const Text('ホームに戻る'),
                ),
                if (!isAllCorrect) ...[
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () {
                      GoRouter.of(context).go('/');
                    },
                    child: const Text('もう一度チャレンジ'),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _RewardItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _RewardItem({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon),
        const SizedBox(width: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
