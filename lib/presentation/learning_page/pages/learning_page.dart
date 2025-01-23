import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/islander_provider.dart';

class LearningPage extends ConsumerWidget {
  const LearningPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final islanderAsync = ref.watch(islanderProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning'),
      ),
      body: islanderAsync.when(
        data: (islander) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Learning Progress: ${islander.learningProgress}%'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  ref.read(islanderProvider.notifier)
                     .updateLearningProgress(islander.learningProgress + 10);
                },
                child: const Text('Study'),
              ),
            ],
          ),
        ),
        loading: () => const CircularProgressIndicator(),
        error: (error, stack) => Text('Error: $error'),
      ),
    );
  }
}
