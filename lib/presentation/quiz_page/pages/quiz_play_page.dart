import 'package:flutter/material.dart';

class QuizPlayPage extends StatefulWidget {
  const QuizPlayPage({
    super.key,
    required this.title,
    required this.question,
    required this.answers,
    required this.correctAnswer,
  });

  final String title;
  final String question;
  final List<String> answers;
  final String correctAnswer;

  @override
  State<QuizPlayPage> createState() => _QuizPlayPageState();
}

class _QuizPlayPageState extends State<QuizPlayPage> {
  String? selectedAnswer;
  bool? isCorrect;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.question,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            ...widget.answers.map((answer) {
              final isSelected = selectedAnswer == answer;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: OutlinedButton(
                  onPressed: isCorrect != null ? null : () {
                    setState(() {
                      selectedAnswer = answer;
                      isCorrect = answer == widget.correctAnswer;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: isSelected
                        ? (isCorrect ?? false)
                            ? Colors.green[100]
                            : Colors.red[100]
                        : null,
                    padding: const EdgeInsets.all(16),
                  ),
                  child: Text(answer),
                ),
              );
            }).toList(),
            if (isCorrect != null) ...[
              const SizedBox(height: 24),
              Text(
                isCorrect! ? '正解！100 satsゲット！' : '不正解...',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: isCorrect! ? Colors.green : Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('クイズ一覧に戻る'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
