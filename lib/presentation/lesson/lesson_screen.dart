import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../model/lesson.dart';
import '../../model/question.dart';
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
                        child: currentQuestion.type == QuestionType.trueFalse
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _TrueFalseButton(
                                    text: currentQuestion.options[0],
                                    isSelected: hasAnswered && lessonState.answers[lessonState.currentQuestionIndex] == 0,
                                    isCorrect: hasAnswered ? 0 == currentQuestion.correctAnswerIndex : null,
                                    onTap: hasAnswered ? null : () => ref.read(lessonStateNotifierProvider.notifier).selectAnswer(0, lesson),
                                  ),
                                  _TrueFalseButton(
                                    text: currentQuestion.options[1],
                                    isSelected: hasAnswered && lessonState.answers[lessonState.currentQuestionIndex] == 1,
                                    isCorrect: hasAnswered ? 1 == currentQuestion.correctAnswerIndex : null,
                                    onTap: hasAnswered ? null : () => ref.read(lessonStateNotifierProvider.notifier).selectAnswer(1, lesson),
                                  ),
                                ],
                              )
                            : ListView.builder(
                                itemCount: currentQuestion.options.length,
                                itemBuilder: (context, index) {
                                  final isSelected = hasAnswered && 
                                      lessonState.answers[lessonState.currentQuestionIndex] == index;
                                  
                                  // 回答後の色分け
                                  Color? backgroundColor;
                                  Color? textColor;
                                  if (hasAnswered) {
                                    if (index == currentQuestion.correctAnswerIndex) {
                                      backgroundColor = Colors.green.withOpacity(0.2);
                                      textColor = Colors.green;
                                    } else if (isSelected) {
                                      backgroundColor = Colors.red.withOpacity(0.2);
                                      textColor = Colors.red;
                                    }
                                  } else if (isSelected) {
                                    backgroundColor = Theme.of(context).colorScheme.primaryContainer;
                                    textColor = Theme.of(context).colorScheme.primary;
                                  }

                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12.0),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: hasAnswered
                                            ? null
                                            : () => ref.read(lessonStateNotifierProvider.notifier).selectAnswer(index, lesson),
                                        borderRadius: BorderRadius.circular(12),
                                        child: Ink(
                                          decoration: BoxDecoration(
                                            color: backgroundColor ?? Theme.of(context).cardColor,
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(
                                              color: isSelected
                                                  ? (textColor ?? Theme.of(context).colorScheme.primary)
                                                  : Colors.grey.withOpacity(0.3),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Text(
                                              currentQuestion.options[index],
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: textColor,
                                                fontWeight: isSelected ? FontWeight.bold : null,
                                              ),
                                            ),
                                          ),
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

// 丸バツボタンウィジェット
class _TrueFalseButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool? isCorrect;
  final VoidCallback? onTap;

  const _TrueFalseButton({
    required this.text,
    required this.isSelected,
    required this.isCorrect,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color borderColor;
    Color textColor;

    if (isCorrect == null) {
      // 未回答時
      if (isSelected) {
        backgroundColor = Theme.of(context).colorScheme.primaryContainer;
        borderColor = Theme.of(context).colorScheme.primary;
        textColor = Theme.of(context).colorScheme.primary;
      } else {
        backgroundColor = Theme.of(context).cardColor;
        borderColor = Colors.grey.withOpacity(0.3);
        textColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
      }
    } else if (isCorrect == true) {
      // 正解
      backgroundColor = Colors.green.withOpacity(0.2);
      borderColor = Colors.green;
      textColor = Colors.green;
    } else {
      // 不正解
      backgroundColor = Colors.red.withOpacity(0.2);
      borderColor = Colors.red;
      textColor = Colors.red;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
