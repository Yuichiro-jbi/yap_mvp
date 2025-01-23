import 'package:flutter/material.dart';
import 'quiz_play_page.dart';

class QuizListPage extends StatelessWidget {
  const QuizListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final quizzes = [
      {
        'title': 'クイズ1',
        'question': 'ビットコインの発行上限は何枚？',
        'answers': ['1000万枚', '2100万枚', '3000万枚', '無制限'],
        'correctAnswer': '2100万枚',
      },
      {
        'title': 'クイズ2',
        'question': 'ビットコインの最小単位は何？',
        'answers': ['satoshi', 'wei', 'gwei', 'ether'],
        'correctAnswer': 'satoshi',
      },
      {
        'title': 'クイズ3',
        'question': 'ビットコインを作ったのは誰？',
        'answers': ['イーロン・マスク', 'サトシ・ナカモト', 'マーク・ザッカーバーグ', 'スティーブ・ジョブズ'],
        'correctAnswer': 'サトシ・ナカモト',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('デイリークイズ'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: quizzes.length,
        itemBuilder: (context, index) {
          final quiz = quizzes[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => QuizPlayPage(
                      title: quiz['title'] as String,
                      question: quiz['question'] as String,
                      answers: (quiz['answers'] as List).cast<String>(),
                      correctAnswer: quiz['correctAnswer'] as String,
                    ),
                  ),
                );
              },
              tileColor: Theme.of(context).colorScheme.primaryContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              leading: Icon(
                Icons.quiz,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(
                quiz['title'] as String,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Text(
                '100 sats',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
