import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/islander_provider.dart';
import '../../learning_page/pages/learning_page.dart';

class TopPage extends ConsumerWidget {
  const TopPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Islanderの状態を監視
    final islanderAsync = ref.watch(islanderProvider);

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
                itemCount: 6,
                itemBuilder: (context, index) {
                  final isLocked = index > 0;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      onTap: isLocked ? null : () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LearningPage(),
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
                        'レッスン ${index + 1}',
                        style: TextStyle(
                          color: isLocked ? Colors.grey[600] : Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
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
