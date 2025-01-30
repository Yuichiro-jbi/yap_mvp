import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/islander_provider.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_statistics.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer(
            builder: (context, ref, child) {
              final islander = ref.watch(islanderNotifierProvider);
              
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ProfileHeader(islander: islander),
                  const SizedBox(height: 24),
                  ProfileStatistics(islander: islander),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
