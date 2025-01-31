import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/lesson.dart';
import '../presentation/common/widgets/main_scaffold.dart';
import '../presentation/home/home_screen.dart';
import '../presentation/lesson/congratulations_screen.dart';
import '../presentation/lesson/lesson_screen.dart';
import '../presentation/profile/profile_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

enum AppRoute {
  home,
  lesson,
  lessonComplete,
  profile,
  leaderboard;

  String get path {
    switch (this) {
      case AppRoute.home:
        return '/';
      case AppRoute.lesson:
        return '/lesson/:id';
      case AppRoute.lessonComplete:
        return '/lesson/:id/complete';
      case AppRoute.profile:
        return '/profile';
      case AppRoute.leaderboard:
        return '/leaderboard';
    }
  }

  String get name => toString().split('.').last;
}

final appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: AppRoute.home.path,
  debugLogDiagnostics: true,
  routes: [
    ShellRoute(
      navigatorKey: shellNavigatorKey,
      builder: (context, state, child) {
        return MainScaffold(child: child);
      },
      routes: [
        GoRoute(
          path: AppRoute.home.path,
          name: AppRoute.home.name,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: AppRoute.profile.path,
          name: AppRoute.profile.name,
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
    GoRoute(
      path: AppRoute.lesson.path,
      name: AppRoute.lesson.name,
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) {
        final lesson = state.extra as Lesson;
        return LessonScreen(lesson: lesson);
      },
    ),
    GoRoute(
      path: AppRoute.lessonComplete.path,
      name: AppRoute.lessonComplete.name,
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) {
        final Map<String, dynamic> extras = state.extra as Map<String, dynamic>;
        return CongratulationsScreen(
          lesson: extras['lesson'] as Lesson,
          answers: extras['answers'] as List<int>,
          isAllCorrect: extras['isAllCorrect'] as bool,
        );
      },
    ),
  ],
);
