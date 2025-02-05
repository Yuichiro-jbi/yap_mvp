import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/islander.dart';
import '../../provider/islander_provider.dart';
import '../../presentation/theme/app_theme.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_statistics.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Consumer(
                  builder: (context, ref, child) {
                    final islander = ref.watch(islanderNotifierProvider);
                    final theme = ref.watch(appThemeNotifierProvider);
                    
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Profile",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                theme.isDarkMode 
                                  ? Icons.dark_mode
                                  : Icons.light_mode,
                              ),
                              onPressed: () {
                                ref.read(appThemeNotifierProvider.notifier).toggleTheme();
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        ProfileHeader(islander: islander),
                        const SizedBox(height: 32),
                        const Text(
                          "Statistics",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white.withOpacity(0.1)
                                  : Theme.of(context).colorScheme.outlineVariant,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Colors.orange.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.local_fire_department,
                                  size: 28,
                                  color: Colors.orange,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    islander.dayStreak.toString(),
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Day streak',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white.withOpacity(0.1)
                                  : Theme.of(context).colorScheme.outlineVariant,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Colors.yellow.shade700.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.bolt,
                                  size: 28,
                                  color: Colors.yellow.shade700,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    islander.experience.toString(),
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Total XP',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white.withOpacity(0.1)
                                  : Theme.of(context).colorScheme.outlineVariant,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Colors.amber.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.currency_bitcoin,
                                  size: 28,
                                  color: Colors.amber,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    islander.sats.toString(),
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Total Sats',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
