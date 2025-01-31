import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_theme.g.dart';

@riverpod
class AppThemeNotifier extends _$AppThemeNotifier {
  @override
  AppTheme build() {
    return const AppTheme(isDarkMode: false);
  }

  void toggleTheme() {
    state = AppTheme(isDarkMode: !state.isDarkMode);
  }
}

/// アプリのテーマを管理するクラス
class AppTheme {
  final bool isDarkMode;

  const AppTheme({
    required this.isDarkMode,
  });

  /// メインのテーマデータ
  ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _lightColorScheme,
      textTheme: _textTheme,
      cardTheme: _cardTheme,
      appBarTheme: _appBarTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
    );
  }

  /// ダークモードのテーマデータ
  ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _darkColorScheme,
      textTheme: _textTheme,
      cardTheme: _cardTheme,
      appBarTheme: _appBarTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
    );
  }

  /// ライトモードのカラースキーム
  ColorScheme get _lightColorScheme {
    return ColorScheme.fromSeed(
      seedColor: const Color(0xFFFFB300), // ビットコインカラー
      primary: const Color(0xFFFFB300),
      secondary: const Color(0xFF1E88E5), // 以前のメインカラーを secondary に
      tertiary: const Color(0xFF00BFA5),
      surface: Colors.white,
      background: const Color(0xFFF5F5F5),
      error: const Color(0xFFE53935),
    );
  }

  /// ダークモードのカラースキーム
  ColorScheme get _darkColorScheme {
    return ColorScheme.fromSeed(
      seedColor: const Color(0xFFFFB300),
      brightness: Brightness.dark,
      primary: const Color(0xFFFFB300),
      secondary: const Color(0xFF1E88E5),
      tertiary: const Color(0xFF00BFA5),
      surface: const Color(0xFF424242),
      background: const Color(0xFF212121),
      error: const Color(0xFFE53935),
    );
  }

  /// テキストテーマ
  TextTheme get _textTheme {
    return const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        letterSpacing: 0.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        letterSpacing: 0.25,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.25,
      ),
    );
  }

  /// カードテーマ
  CardTheme get _cardTheme {
    return CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
    );
  }

  /// AppBarテーマ
  AppBarTheme get _appBarTheme {
    return const AppBarTheme(
      centerTitle: true,
      elevation: 0,
    );
  }

  /// ElevatedButtonテーマ
  ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  /// アプリ全体で使用する定数値
  static const double spacing4 = 4;
  static const double spacing8 = 8;
  static const double spacing12 = 12;
  static const double spacing16 = 16;
  static const double spacing24 = 24;
  static const double spacing32 = 32;
  
  static const double radius8 = 8;
  static const double radius12 = 12;
  static const double radius16 = 16;
  static const double radius24 = 24;
}
