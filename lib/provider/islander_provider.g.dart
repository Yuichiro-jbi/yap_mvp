// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'islander_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$islanderNotifierHash() => r'9e9cac41544c49a824dfbdd889e09471878fb706';

/// IslanderProviderの責任範囲:
/// 1. Islanderの状態管理
///   - 経験値の管理と更新
///   - 所持Satsの管理と更新
///   - 完了したレッスンIDの管理
///
/// 2. Islanderに関するビジネスロジック
///   - レッスン完了時の報酬付与処理
///   - レベルアップの判定と処理
///   - 新規Islander作成時の初期化
///
/// 3. 永続化（将来的な拡張）
///   - Islanderデータの保存
///   - 保存したデータの読み込み
///
/// このプロバイダーは、ゲームの進行状況やユーザーの成長に関する
/// すべての状態とロジックを一元管理します。
///
/// Copied from [IslanderNotifier].
@ProviderFor(IslanderNotifier)
final islanderNotifierProvider =
    AutoDisposeNotifierProvider<IslanderNotifier, Islander>.internal(
  IslanderNotifier.new,
  name: r'islanderNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$islanderNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IslanderNotifier = AutoDisposeNotifier<Islander>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
