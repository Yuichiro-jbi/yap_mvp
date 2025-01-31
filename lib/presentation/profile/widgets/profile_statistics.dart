import 'package:flutter/material.dart';
import '../../../model/islander.dart';

class ProfileStatistics extends StatelessWidget {
  final Islander islander;

  const ProfileStatistics({
    super.key,
    required this.islander,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _StatItem(
          icon: Icons.local_fire_department,
          value: "1",
          label: "Day streak",
          color: Colors.orange,
        ),
        _StatItem(
          icon: Icons.flash_on,
          value: islander.experience.toString(),
          label: "Total XP",
          color: Colors.yellow,
        ),
        _StatItem(
          icon: Icons.workspace_premium,
          value: "Gold",
          label: "League",
          color: Colors.amber,
        ),
        _StatItem(
          icon: Icons.emoji_events,
          value: "0",
          label: "Top 3 finishes",
          color: Colors.grey,
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
