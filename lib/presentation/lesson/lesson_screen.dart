import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../model/lesson.dart';
import '../../provider/lesson_state_provider.dart';
import '../../router/app_router.dart';
import 'congratulations_screen.dart';

class LessonScreen extends StatelessWidget {
  final Lesson lesson;

  const LessonScreen({
    super.key,
    required this.lesson,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lesson.title),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final lessonState = ref.watch(lessonStateNotifierProvider);
          final currentQuestion = lesson.questions[lessonState.currentQuestionIndex];
          final hasAnswered = lessonState.hasSelectedCurrentAnswer;
          final isCorrect = hasAnswered ? lessonState.isCurrentQuestionCorrect() : null;

          return Column(
            children: [
              // プログレスバー
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Stack(
                  children: [
                    Container(
                      width: 360,
                      height: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xFFE5E5E5),
                      ),
                    ),
                    Container(
                      width: 360 * ((lessonState.currentQuestionIndex + 1) / lesson.questions.length),
                      height: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              // 問題番号表示
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '問題 ${lessonState.currentQuestionIndex + 1} / ${lesson.questions.length}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentQuestion.question,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 24),
                      Expanded(
                        child: ListView.builder(
                          itemCount: currentQuestion.options.length,
                          itemBuilder: (context, index) {
                            final isSelected = hasAnswered && 
                                lessonState.answers[lessonState.currentQuestionIndex] == index;
                            
                            // 回答後の色分け
                            Color? backgroundColor;
                            Color? textColor;
                            if (hasAnswered) {
                              if (index == currentQuestion.correctAnswerIndex) {
                                // 正解の選択肢
                                backgroundColor = Colors.green.withOpacity(0.2);
                                textColor = Colors.green;
                              } else if (isSelected) {
                                // 選択した不正解の選択肢
                                backgroundColor = Colors.red.withOpacity(0.2);
                                textColor = Colors.red;
                              }
                            } else if (isSelected) {
                              // 未回答時の選択中の選択肢
                              backgroundColor = Theme.of(context).colorScheme.primaryContainer;
                              textColor = Theme.of(context).colorScheme.primary;
                            }

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: OutlinedButton(
                                onPressed: hasAnswered ? null : () {
                                  ref.read(lessonStateNotifierProvider.notifier)
                                      .selectAnswer(index, lesson);
                                },
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: backgroundColor,
                                  padding: const EdgeInsets.all(20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  currentQuestion.options[index],
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color: textColor,
                                      ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (hasAnswered) ...[
                // 正誤判定の表示
                Container(
                  padding: const EdgeInsets.all(16.0),
                  color: isCorrect == true ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                  child: Text(
                    isCorrect == true ? '正解！' : '不正解...',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: isCorrect == true ? Colors.green : Colors.red,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: hasAnswered
                      ? () {
                          final isLastQuestion =
                              lessonState.currentQuestionIndex == lesson.questions.length - 1;

                          if (isLastQuestion) {
                            // 最後の問題なら結果画面へ
                            GoRouter.of(context).pushNamed(
                              AppRoute.lessonComplete.name,
                              pathParameters: {'id': lesson.id},
                              extra: {
                                'lesson': lesson,
                                'answers': lessonState.answers,
                                'isAllCorrect': lessonState.isCompleted,
                              },
                            );
                          } else {
                            // 次の問題へ
                            ref
                                .read(lessonStateNotifierProvider.notifier)
                                .nextQuestion(lesson);
                          }
                        }
                      : null,
                  child: Text(
                    lessonState.currentQuestionIndex == lesson.questions.length - 1
                        ? '完了'
                        : '次へ',
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
