import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../providers/islander_provider.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    _loadDataAndNavigate();
  }

  Future<void> _loadDataAndNavigate() async {
    try {
      // データを先読み
      await ref.read(islanderProvider.future);
      
      // 最低3秒は表示
      await Future.delayed(const Duration(seconds: 3));
      
      if (!mounted) return;
      context.go('/top');
    } catch (e) {
      print('Error loading data: $e');
      // エラー時も3秒後にトップページへ
      await Future.delayed(const Duration(seconds: 3));
      if (!mounted) return;
      context.go('/top');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.landscape,
              size: 100,
              color: Colors.orange,
            ),
            SizedBox(height: 16),
            Text(
              'ヤップ アイランド',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
