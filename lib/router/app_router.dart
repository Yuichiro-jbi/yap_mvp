import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/lesson.dart';
import '../presentation/home/home_screen.dart';
import '../presentation/lesson/congratulations_screen.dart';
import '../presentation/lesson/lesson_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

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
    GoRoute(
      path: AppRoute.home.path,
      name: AppRoute.home.name,
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: AppRoute.lesson.path,
      name: AppRoute.lesson.name,
      builder: (context, state) {
        final lesson = state.extra as Lesson;
        return LessonScreen(lesson: lesson);
      },
    ),
    GoRoute(
      path: AppRoute.lessonComplete.path,
      name: AppRoute.lessonComplete.name,
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
