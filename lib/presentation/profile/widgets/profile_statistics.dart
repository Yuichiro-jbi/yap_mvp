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
          borderColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.grey[300]!,
        ),
        _StatItem(
          icon: Icons.flash_on,
          value: islander.experience.toString(),
          label: "Total XP",
          color: Colors.yellow,
          borderColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.grey[300]!,
        ),
        _StatItem(
          icon: Icons.currency_bitcoin,
          value: "${islander.sats}",
          label: "Total Sats",
          color: const Color(0xFFFFB300),
          borderColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.grey[300]!,
        ),
        _StatItem(
          icon: Icons.emoji_events,
          value: "0",
          label: "Top 3 finishes",
          color: Colors.grey,
          borderColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.grey[300]!,
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
  final Color borderColor;

  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
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
