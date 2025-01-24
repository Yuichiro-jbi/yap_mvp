import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/lesson_provider.dart';
import '../../../providers/islander_provider.dart';

class LearningPage extends ConsumerStatefulWidget {
  final int lessonNumber;

  const LearningPage({super.key, required this.lessonNumber});

  @override
  ConsumerState<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends ConsumerState<LearningPage> {
  int currentQuestionIndex = 0;
  bool showExplanation = false;
  int? selectedOptionIndex;

  @override
  Widget build(BuildContext context) {
    final lessonsState = ref.watch(lessonProvider);
    final islanderAsync = ref.watch(islanderProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('レッスン'),
      ),
      body: lessonsState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('エラー: $error')),
        data: (lessons) {
          final lesson = lessons.firstWhere(
            (l) => l.lessonNumber == widget.lessonNumber,
            orElse: () => throw Exception('レッスンが見つかりません'),
          );
          final questions = lesson.questions;
          final totalQuestions = questions.length;
          final currentQuestion = questions[currentQuestionIndex];

          return islanderAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text('エラー: $error')),
            data: (islander) => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    LinearProgressIndicator(
                      value: (currentQuestionIndex + 1) / totalQuestions,
                      backgroundColor: Colors.grey[200],
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      lesson.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      lesson.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '問題 ${currentQuestionIndex + 1}/$totalQuestions',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      currentQuestion.text,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 24),
                    ...List.generate(
                      currentQuestion.options.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(16),
                            backgroundColor: showExplanation
                                ? index == currentQuestion.correctIndex
                                    ? Colors.green[100]
                                    : selectedOptionIndex == index
                                        ? Colors.red[100]
                                        : null
                                : selectedOptionIndex == index
                                    ? Theme.of(context).colorScheme.primaryContainer
                                    : null,
                          ),
                          onPressed: showExplanation
                              ? null
                              : () {
                                  setState(() {
                                    selectedOptionIndex = index;
                                    showExplanation = true;
                                  });
                                },
                          child: Text(
                            currentQuestion.options[index],
                            style: TextStyle(
                              color: showExplanation && index == currentQuestion.correctIndex
                                  ? Colors.green[900]
                                  : showExplanation && index == selectedOptionIndex
                                      ? Colors.red[900]
                                      : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (showExplanation) Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '解説',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(lesson.explanations[currentQuestion.id] ?? ''),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () async {
                              if (currentQuestionIndex < totalQuestions - 1) {
                                setState(() {
                                  currentQuestionIndex++;
                                  showExplanation = false;
                                  selectedOptionIndex = null;
                                });
                              } else {
                                // レッスン完了時の処理
                                final current = ref.read(islanderProvider).value!;
                                // 現在のレッスン番号が進捗より大きい場合のみ更新とEXP付与
                                if (widget.lessonNumber > current.learningProgress) {
                                  await ref.read(islanderProvider.notifier)
                                      .updateLearningProgress(widget.lessonNumber);
                                  // EXPの加算（新規クリア時のみ）
                                  await ref.read(islanderProvider.notifier)
                                      .updateExp(current.exp + lesson.exp.toInt());
                                }
                                Navigator.of(context).pop();
                              }
                            },
                            child: Text(
                              currentQuestionIndex < totalQuestions - 1 ? '次の問題へ' : 'レッスン完了',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
