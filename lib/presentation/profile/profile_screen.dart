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
                        ProfileStatistics(islander: islander),
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
