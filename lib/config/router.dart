import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../presentation/learning_page/pages/learning_page.dart';
import '../presentation/my_page/pages/my_page.dart';
import '../presentation/quiz_page/pages/quiz_list_page.dart';
import '../presentation/splash_page/pages/splash_page.dart';
import '../presentation/top_page/pages/top_page.dart';
import '../presentation/treasure_page/pages/treasure_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/lesson/:lessonNumber',
        builder: (context, state) {
          final lessonNumber = int.parse(state.pathParameters['lessonNumber']!);
          return LearningPage(lessonNumber: lessonNumber);
        },
      ),
      ShellRoute(
        builder: (context, state, child) {
          return ScaffoldWithBottomNavBar(child: child);
        },
        routes: [
          GoRoute(
            path: '/top',
            builder: (context, state) => const TopPage(),
          ),
          GoRoute(
            path: '/quiz',
            builder: (context, state) => const QuizListPage(),
          ),
          GoRoute(
            path: '/treasure',
            builder: (context, state) => const TreasurePage(),
          ),
          GoRoute(
            path: '/mypage',
            builder: (context, state) => const MyPage(),
          ),
        ],
      ),
    ],
  );
});

class ScaffoldWithBottomNavBar extends StatelessWidget {
  const ScaffoldWithBottomNavBar({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _calculateSelectedIndex(context),
        onDestinationSelected: (index) => _onItemTapped(index, context),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'トップ',
          ),
          NavigationDestination(
            icon: Icon(Icons.quiz),
            label: 'クイズ',
          ),
          NavigationDestination(
            icon: Icon(Icons.card_giftcard),
            label: '宝箱',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'マイページ',
          ),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/top')) return 0;
    if (location.startsWith('/quiz')) return 1;
    if (location.startsWith('/treasure')) return 2;
    if (location.startsWith('/mypage')) return 3;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/top');
        break;
      case 1:
        GoRouter.of(context).go('/quiz');
        break;
      case 2:
        GoRouter.of(context).go('/treasure');
        break;
      case 3:
        GoRouter.of(context).go('/mypage');
        break;
    }
  }
}
