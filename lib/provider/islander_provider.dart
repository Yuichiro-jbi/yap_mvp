import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../model/islander.dart';

part 'islander_provider.g.dart';

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

@riverpod
class IslanderNotifier extends _$IslanderNotifier {
  /// 初期状態のIslanderを生成
  /// - 経験値: 0
  /// - Sats: 0
  /// - 完了レッスン: 空のリスト
  @override
  Islander build() {
    return Islander(
      id: 'test-user-id',
      name: 'YAP君',
      experience: 0,
      sats: 0,
      createdAt: DateTime(2025, 1, 1),
      completedLessonIds: [],
    );
  }

  /// レッスン完了時の報酬付与処理
  /// - 経験値を加算
  /// - Satsを加算
  /// - 完了レッスンリストに追加
  /// @param lessonId 完了したレッスンのID
  /// @param experienceReward 獲得経験値
  /// @param satsReward 獲得Sats
  void completeLesson(String lessonId, int experienceReward, int satsReward) {
    state = Islander(
      id: state.id,
      name: state.name,
      experience: state.experience + experienceReward,
      sats: state.sats + satsReward,
      createdAt: state.createdAt,
      completedLessonIds: [...state.completedLessonIds, lessonId],
    );
  }

  /// レッスン完了時の報酬付与
  void addRewards(int experienceReward, int satsReward, String lessonId) {
    state = state.copyWith(
      experience: state.experience + experienceReward,
      sats: state.sats + satsReward,
      completedLessonIds: [...state.completedLessonIds, lessonId],
    );
  }

  /// レッスンが完了済みかどうかを判定
  /// @param lessonId 確認するレッスンのID
  /// @return bool 完了済みの場合true
  bool isLessonCompleted(String lessonId) {
    return state.completedLessonIds.contains(lessonId);
  }
}
