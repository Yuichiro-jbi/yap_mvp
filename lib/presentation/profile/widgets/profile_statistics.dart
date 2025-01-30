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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Statistics",
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _StatItem(
              icon: "assets/images/Vector.png",
              value: "1",
              label: "Day streak",
            ),
            _StatItem(
              icon: "assets/images/Vector.png",
              value: islander.experience.toString(),
              label: "Total XP",
            ),
            _StatItem(
              icon: "assets/images/Vector.png",
              value: "Gold",
              label: "League",
            ),
            _StatItem(
              icon: "assets/images/Vector.png",
              value: "0",
              label: "Top 3 finishes",
            ),
          ],
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String icon;
  final String value;
  final String label;

  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          icon,
          width: 24,
          height: 24,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
