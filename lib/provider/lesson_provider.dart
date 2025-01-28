import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../model/lesson.dart';
import 'islander_provider.dart';

part 'lesson_provider.g.dart';

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

@riverpod
class LessonNotifier extends _$LessonNotifier {
  /// 初期レッスンリストの生成
  /// - ハードコードされたレッスンデータを提供
  /// - 将来的にはAPIから取得予定
  @override
  List<Lesson> build() {
    // 初期データとしてサンプルレッスンを返す
    return [
      Lesson(
        id: '1',
        title: 'ビットコインの基礎',
        description: 'ビットコインの基本的な概念について学びましょう',
        questions: [
          Question(
            id: 'q1',
            question: 'ビットコインは誰が作った？',
            options: [
              'サトシ・ナカモト',
              'スティーブ・ジョブズ',
              'マーク・ザッカーバーグ',
              'イーロン・マスク'
            ],
            correctAnswerIndex: 0,
            explanation: 'ビットコインは2008年にサトシ・ナカモトによって発表されました。',
          ),
          Question(
            id: 'q2',
            question: 'ビットコインの最大発行枚数は？',
            options: [
              '1000万BTC',
              '2100万BTC',
              '5000万BTC',
              '1億BTC'
            ],
            correctAnswerIndex: 1,
            explanation: 'ビットコインの最大発行枚数は2100万BTCに設定されています。',
          ),
        ],
        experienceReward: 100,
        coinReward: 100,
      ),
      Lesson(
        id: '2',
        title: 'ライトニングネットワーク入門',
        description: 'ビットコインのスケーラビリティソリューションについて学びましょう',
        questions: [
          Question(
            id: 'q1',
            question: 'ライトニングネットワークは何を解決する？',
            options: [
              'スケーラビリティ問題',
              'セキュリティ問題',
              'プライバシー問題',
              'マイニング問題'
            ],
            correctAnswerIndex: 0,
            explanation: 'ライトニングネットワークは、ビットコインのスケーラビリティ問題を解決するために開発されました。',
          ),
          Question(
            id: 'q2',
            question: 'ライトニングネットワークは何のレイヤー？',
            options: [
              'レイヤー1',
              'レイヤー2',
              'レイヤー3',
              'レイヤー4'
            ],
            correctAnswerIndex: 1,
            explanation: 'ライトニングネットワークは、ビットコインのレイヤー2ソリューションです。',
          ),
        ],
        experienceReward: 150,
        coinReward: 150,
      ),
    ];
  }

  /// 指定されたIDのレッスンを取得
  /// @param id レッスンID
  /// @return Lesson? 該当するレッスン、存在しない場合はnull
  Lesson? getLessonById(String id) {
    try {
      return state.firstWhere((lesson) => lesson.id == id);
    } catch (e) {
      return null;
    }
  }

  /// 正解数をカウント
  int countCorrectAnswers(String lessonId, List<int> answers) {
    final lesson = getLessonById(lessonId);
    if (lesson == null) return 0;

    var correctCount = 0;
    for (var i = 0; i < answers.length; i++) {
      if (i < lesson.questions.length && 
          answers[i] == lesson.questions[i].correctAnswerIndex) {
        correctCount++;
      }
    }
    return correctCount;
  }

  /// レッスンを完了する
  void completeLesson(String lessonId) {
    state = [
      for (final lesson in state)
        if (lesson.id == lessonId)
          lesson.copyWith(isCompleted: true)
        else
          lesson
    ];
  }

  /// レッスンが完了しているかどうかを判定する
  /// @param lessonId レッスンID
  /// @return bool レッスンが完了している場合true
  bool isLessonCompleted(String lessonId) {
    final islander = ref.read(islanderNotifierProvider);
    return islander.completedLessonIds.contains(lessonId);
  }
}
