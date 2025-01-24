import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/islander_provider.dart';

class TreasurePage extends ConsumerWidget {
  const TreasurePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final islanderAsync = ref.watch(islanderProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('宝箱'),
      ),
      body: islanderAsync.when(
        data: (islander) => Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        '${islander.sats} sats',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '≒ ¥${islander.sats / 20}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('エラーが発生しました: $error'),
        ),
      ),
    );
  }
}
