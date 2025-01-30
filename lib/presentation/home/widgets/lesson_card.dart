import 'package:flutter/material.dart';
import '../../../model/lesson.dart';

class LessonCard extends StatelessWidget {
  final Lesson lesson;
  final VoidCallback onTap;
  final bool isCompleted;
  final bool isLocked;

  const LessonCard({
    super.key,
    required this.lesson,
    required this.onTap,
    required this.isCompleted,
    required this.isLocked,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isLocked ? 1 : 2,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: InkWell(
        onTap: isLocked ? null : onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              _buildIcon(context),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lesson.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: isLocked
                            ? Theme.of(context).colorScheme.onSurface.withOpacity(0.5)
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      lesson.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isLocked
                            ? Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5)
                            : Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    if (!isLocked) ...[
                      const SizedBox(height: 8),
                      _buildRewards(context),
                    ],
                  ],
                ),
              ),
              if (!isLocked && isCompleted)
                Icon(
                  Icons.check_circle,
                  color: Theme.of(context).colorScheme.primary,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: _getIconBackgroundColor(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        isLocked ? Icons.lock : (isCompleted ? Icons.check_circle : Icons.play_arrow),
        color: _getIconColor(context),
      ),
    );
  }

  Widget _buildRewards(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          color: Theme.of(context).colorScheme.primary,
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          '+${lesson.experienceReward}exp',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 16),
        Icon(
          Icons.currency_bitcoin,
          color: Theme.of(context).colorScheme.secondary,
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          '+${lesson.coinReward} sats',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Color _getIconBackgroundColor(BuildContext context) {
    if (isLocked) {
      return Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5);
    }
    return isCompleted
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.primaryContainer;
  }

  Color _getIconColor(BuildContext context) {
    if (isLocked) {
      return Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5);
    }
    return isCompleted
        ? Theme.of(context).colorScheme.onPrimary
        : Theme.of(context).colorScheme.onPrimaryContainer;
  }
}
