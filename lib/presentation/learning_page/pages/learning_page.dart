import 'package:flutter/material.dart';

class LearningPage extends StatefulWidget {
  const LearningPage({
    super.key,
    required this.lessonNumber,
  });

  final int lessonNumber;

  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  int currentQuestionIndex = 0;
  List<bool?> answers = List.filled(3, null);

  final questions = [
    {
      'question': 'ビットコインはどんな技術？',
      'explanation': 'ビットコインは中央管理者なしで運営される分散型のデジタル通貨です。',
      'answers': ['分散型デジタル通貨', '中央集権型デジタル通貨', '電子マネー', 'ポイントシステム'],
      'correctAnswer': '分散型デジタル通貨',
    },
    {
      'question': 'ビットコインのブロック生成間隔は？',
      'explanation': 'ビットコインは約10分ごとに新しいブロックが生成されるように設計されています。',
      'answers': ['1分', '5分', '10分', '30分'],
      'correctAnswer': '10分',
    },
    {
      'question': 'ビットコインのトランザクションは誰が承認する？',
      'explanation': 'マイナーと呼ばれる参加者が取引を承認し、新しいブロックを生成します。',
      'answers': ['銀行', '政府', 'マイナー', '開発者'],
      'correctAnswer': 'マイナー',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('レッスン${widget.lessonNumber}'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  '${currentQuestionIndex + 1}/3',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: LinearProgressIndicator(
                    value: (currentQuestionIndex + (answers[currentQuestionIndex] != null ? 1 : 0)) / 3,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          questions[currentQuestionIndex]['question'] as String,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ...(questions[currentQuestionIndex]['answers'] as List)
                        .map((answer) {
                      final isSelected = answers[currentQuestionIndex] != null &&
                          answer == questions[currentQuestionIndex]['correctAnswer'];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: OutlinedButton(
                          onPressed: answers[currentQuestionIndex] != null
                              ? null
                              : () {
                                  setState(() {
                                    answers[currentQuestionIndex] =
                                        answer == questions[currentQuestionIndex]['correctAnswer'];
                                  });
                                },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: isSelected
                                ? Colors.green[100]
                                : null,
                            padding: const EdgeInsets.all(16),
                          ),
                          child: Text(answer as String),
                        ),
                      );
                    }).toList(),
                    if (answers[currentQuestionIndex] != null) ...[
                      const SizedBox(height: 24),
                      Card(
                        color: answers[currentQuestionIndex]!
                            ? Colors.green[50]
                            : Colors.red[50],
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text(
                                answers[currentQuestionIndex]!
                                    ? '正解！'
                                    : '不正解...',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: answers[currentQuestionIndex]!
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                questions[currentQuestionIndex]['explanation'] as String,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      if (currentQuestionIndex < 2)
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              currentQuestionIndex++;
                            });
                          },
                          child: const Text('次の問題へ'),
                        )
                      else
                        OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('レッスン一覧に戻る'),
                        ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
