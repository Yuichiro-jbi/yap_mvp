import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../router/app_router.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;

  const MainScaffold({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),  
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(
                  context,
                  index: 0,
                  isSelected: _calculateSelectedIndex(context) == 0,
                  icon: Icons.home_outlined,
                  selectedIcon: Icons.home,
                ),
                _buildNavItem(
                  context,
                  index: 1,
                  isSelected: _calculateSelectedIndex(context) == 1,
                  icon: Icons.person_outline,
                  selectedIcon: Icons.person,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required bool isSelected,
    required IconData icon,
    required IconData selectedIcon,
  }) {
    final color = isSelected
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onSurfaceVariant;

    return InkWell(
      onTap: () => _onItemTapped(index, context),
      child: Container(
        width: 60,
        padding: const EdgeInsets.only(bottom: 0),  
        child: Icon(
          isSelected ? selectedIcon : icon,
          color: color,
          size: 30,  
        ),
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith(AppRoute.profile.path)) {
      return 1;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.goNamed(AppRoute.home.name);
        break;
      case 1:
        context.goNamed(AppRoute.profile.name);
        break;
    }
  }
}
