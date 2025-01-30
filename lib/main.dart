import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/common/widgets/main_scaffold.dart';
import 'presentation/home/home_screen.dart';
import 'presentation/profile/profile_screen.dart';
import 'presentation/theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final theme = ref.watch(appThemeProvider);
        
        return MaterialApp(
          title: 'YAP',
          theme: theme.lightTheme,
          darkTheme: theme.darkTheme,
          debugShowCheckedModeBanner: false,
          home: const MainScaffold(
            screens: [
              HomeScreen(),
              ProfileScreen(),
            ],
          ),
        );
      },
    );
  }
}
