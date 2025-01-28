import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'app_router.dart';

part 'navigation_service.g.dart';

@riverpod
class NavigationService extends _$NavigationService {
  @override
  void build() {
    // ステートレスなサービス
    return;
  }

  void goToHome() {
    _go(AppRoute.home);
  }

  void goToLogin() {
    _go(AppRoute.login);
  }

  void goToLesson(String lessonId) {
    _go(AppRoute.lesson, params: {'id': lessonId});
  }

  void goToProfile() {
    _go(AppRoute.profile);
  }

  void goToLeaderboard() {
    _go(AppRoute.leaderboard);
  }

  void pop() {
    rootNavigatorKey.currentContext?.pop();
  }

  void _go(AppRoute route, {Map<String, String> params = const {}}) {
    final context = rootNavigatorKey.currentContext;
    if (context == null) return;

    context.goNamed(
      route.name,
      pathParameters: params,
    );
  }
}
