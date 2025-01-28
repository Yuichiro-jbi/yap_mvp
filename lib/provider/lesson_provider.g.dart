// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$lessonNotifierHash() => r'601e7f057eff621e7135fa61e52c7ca957cc9a02';

/// LessonProviderの責任範囲:
/// 1. レッスンコンテンツの管理
///   - 利用可能なレッスンのリスト管理
///   - レッスンの詳細情報（問題、選択肢、正解）の提供
///   - レッスンの報酬情報の管理
///
/// 2. レッスンの進行状況管理
///   - 完了済みレッスンの判定（IslanderProviderと連携）
///   - 次に挑戦可能なレッスンの判定
///   - レッスンの難易度管理
///
/// 3. レッスンデータの取得（将来的な拡張）
///   - APIからのレッスンデータの取得
///   - レッスンデータのキャッシュ管理
///
/// このプロバイダーは、アプリケーション全体で利用可能な
/// レッスンコンテンツとその進行状況を管理します。
///
/// Copied from [LessonNotifier].
@ProviderFor(LessonNotifier)
final lessonNotifierProvider =
    AutoDisposeNotifierProvider<LessonNotifier, List<Lesson>>.internal(
  LessonNotifier.new,
  name: r'lessonNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$lessonNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LessonNotifier = AutoDisposeNotifier<List<Lesson>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
