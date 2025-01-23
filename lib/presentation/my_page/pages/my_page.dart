import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../providers/islander_provider.dart';

class MyPage extends ConsumerWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Islanderの状態を監視
    final islanderAsync = ref.watch(islanderProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('マイページ'),
      ),
      body: islanderAsync.when(
        data: (islander) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ステータス',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _StatusCard(
                  title: '経験値',
                  value: islander.exp.toString(),
                  icon: Icons.star,
                ),
                const SizedBox(height: 8),
                _StatusCard(
                  title: 'Sats',
                  value: islander.sats.toString(),
                  icon: Icons.currency_bitcoin,
                ),
                const SizedBox(height: 8),
                _StatusCard(
                  title: 'ログイン日数',
                  value: '${islander.loginDays}日',
                  icon: Icons.calendar_today,
                ),
                const SizedBox(height: 8),
                _StatusCard(
                  title: '学習進捗',
                  value: '${islander.learningProgress}%',
                  icon: Icons.school,
                ),
                const SizedBox(height: 16),
                Text(
                  '登録日: ${DateFormat('yyyy/MM/dd').format(islander.createdAt)}',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
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

class _StatusCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatusCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
