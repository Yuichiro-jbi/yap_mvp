import 'package:flutter/material.dart';
import '../../../presentation/learning_page/pages/learning_page.dart';

class TopPage extends StatelessWidget {
  const TopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('トップ'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '1000 sats',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 6,
        itemBuilder: (context, index) {
          final isLocked = index > 0;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _LearningButton(
              index: index + 1,
              isLocked: isLocked,
            ),
          );
        },
      ),
    );
  }
}

class _LearningButton extends StatelessWidget {
  const _LearningButton({
    required this.index,
    required this.isLocked,
  });

  final int index;
  final bool isLocked;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: isLocked ? null : () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => LearningPage(
              lessonNumber: index,
            ),
          ),
        );
      },
      tileColor: isLocked ? Colors.grey[100] : Theme.of(context).colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      leading: Icon(
        isLocked ? Icons.lock : Icons.school,
        color: isLocked ? Colors.grey[600] : Theme.of(context).colorScheme.primary,
      ),
      title: Text(
        'レッスン$index',
        style: TextStyle(
          color: isLocked ? Colors.grey[600] : Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
