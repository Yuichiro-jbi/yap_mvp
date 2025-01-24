import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../providers/islander_provider.dart';
import '../../../services/lesson_service.dart';
import '../../learning_page/pages/learning_page.dart';

class TopPage extends ConsumerWidget {
  const TopPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Islanderの状態を監視
    final islanderAsync = ref.watch(islanderProvider);
    final lessonService = ref.watch(lessonServiceProvider.notifier);
    final lessons = lessonService.getAllLessons();

    return Scaffold(
      appBar: AppBar(
        title: const Text('YAP Island'),
        actions: [
          // 上部のステータス表示
          islanderAsync.when(
            data: (islander) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text(
                    'EXP: ${islander.exp}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.currency_bitcoin, color: Colors.orange),
                  const SizedBox(width: 4),
                  Text(
                    'Sats: ${islander.sats}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: islanderAsync.when(
        data: (islander) => SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                itemCount: lessons.length,
                itemBuilder: (context, index) {
                  final lesson = lessons[index];
                  // レッスンのアンロック状態を判定
                  final isUnlocked = lessonService.isLessonUnlocked(
                    lesson.lessonNumber,
                    islander.learningProgress,
                  );
                  
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      onTap: isUnlocked ? () {
                        context.push('/lesson/${lesson.lessonNumber}');
                      } : null,
                      tileColor: isUnlocked 
                          ? Theme.of(context).colorScheme.primaryContainer 
                          : Colors.grey[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      leading: Icon(
                        isUnlocked ? Icons.school : Icons.lock,
                        color: isUnlocked 
                            ? Theme.of(context).colorScheme.primary 
                            : Colors.grey[600],
                      ),
                      title: Text(
                        lesson.title,
                        style: TextStyle(
                          color: isUnlocked 
                              ? Theme.of(context).colorScheme.primary 
                              : Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        lesson.description,
                        style: TextStyle(
                          color: isUnlocked ? null : Colors.grey[600],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Text('エラーが発生しました: $error'),
        ),
      ),
    );
  }
}
