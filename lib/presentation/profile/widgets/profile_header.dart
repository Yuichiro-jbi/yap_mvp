import 'package:flutter/material.dart';
import '../../../model/islander.dart';

class ProfileHeader extends StatelessWidget {
  final Islander islander;

  const ProfileHeader({
    super.key,
    required this.islander,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          child: Image.asset(
            "assets/images/Vector.png",
            width: 19.47,
            height: 19.5,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                islander.name,
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Image.asset(
                    "assets/images/Vector.png",
                    width: 16,
                    height: 16,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Joined March 2021",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    "0 Friends",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
