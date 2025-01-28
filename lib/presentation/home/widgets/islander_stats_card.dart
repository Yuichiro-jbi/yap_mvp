import 'package:flutter/material.dart';
import '../../../model/islander.dart';

class IslanderStatsCard extends StatelessWidget {
  final Islander islander;

  const IslanderStatsCard({
    super.key,
    required this.islander,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStat(
              icon: Icons.flash_on,
              label: '経験値',
              value: islander.experience.toString(),
            ),
            _buildStat(
              icon: Icons.bolt,
              label: 'Sats',
              value: islander.sats.toString(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
