import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'router/app_router.dart';
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
        
        return MaterialApp.router(
          routerConfig: appRouter,
          title: 'YAP',
          theme: theme.lightTheme,
          darkTheme: theme.darkTheme,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
