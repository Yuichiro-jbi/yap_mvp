import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../model/lesson.dart';

part 'lesson_state_provider.g.dart';

/// LessonStateProviderの責任範囲:
/// 1. レッスン画面の一時的な状態管理
///   - 現在の質問インデックスの管理
///   - ユーザーの回答履歴の管理
///   - 回答選択状態の管理
/// 
/// 2. レッスンの進行制御
///   - 次の問題への遷移判定
///   - レッスン完了判定
///   - 回答状態のリセット
/// 
/// 3. UIとの連携
///   - 回答選択時の状態更新
///   - プログレスバーの進捗計算
///   - 「次へ」ボタンの有効/無効制御
/// 
/// このプロバイダーは、単一のレッスン実行中の一時的な状態のみを
/// 管理し、レッスン終了時にはリセットされます。

class LessonState {
  final List<int> answers;          // ユーザーの回答履歴
  final List<bool> correctAnswers;  // 各問題の正誤判定結果
  final int currentQuestionIndex;   // 現在の問題インデックス
  final bool isCompleted;           // 全問正解したかどうか

  const LessonState({
    required this.answers,
    required this.correctAnswers,
    required this.currentQuestionIndex,
    required this.isCompleted,
  });

  LessonState copyWith({
    List<int>? answers,
    List<bool>? correctAnswers,
    int? currentQuestionIndex,
    bool? isCompleted,
  }) {
    return LessonState(
      answers: answers ?? this.answers,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  /// 現在の質問に回答済みかどうかを判定
  bool get hasSelectedCurrentAnswer {
    return currentQuestionIndex < answers.length;
  }

  /// 現在の質問が正解かどうかを判定
  bool isCurrentQuestionCorrect() {
    return currentQuestionIndex < correctAnswers.length &&
        correctAnswers[currentQuestionIndex];
  }
}

@riverpod
class LessonStateNotifier extends AutoDisposeNotifier<LessonState> {
  /// 初期状態の生成
  /// - 回答リスト: 空
  /// - 正誤判定リスト: 空
  /// - 現在の質問インデックス: 0
  /// - 完了フラグ: false
  @override
  LessonState build() {
    return const LessonState(
      answers: [],
      correctAnswers: [],
      currentQuestionIndex: 0,
      isCompleted: false,
    );
  }

  /// 回答を選択し、正誤判定を行う
  /// @param answerIndex 選択された回答のインデックス
  /// @param lesson 現在のレッスン
  void selectAnswer(int answerIndex, Lesson lesson) {
    final newAnswers = [...state.answers];
    final newCorrectAnswers = [...state.correctAnswers];
    
    // 現在の問題の正解を取得
    final correctAnswer = lesson.questions[state.currentQuestionIndex].correctAnswerIndex;
    final isCorrect = answerIndex == correctAnswer;

    // 回答を記録
    if (state.currentQuestionIndex >= newAnswers.length) {
      newAnswers.add(answerIndex);
      newCorrectAnswers.add(isCorrect);
    } else {
      newAnswers[state.currentQuestionIndex] = answerIndex;
      newCorrectAnswers[state.currentQuestionIndex] = isCorrect;
    }

    // 全問正解したかチェック
    final allCorrect = newCorrectAnswers.length == lesson.questions.length &&
        newCorrectAnswers.every((correct) => correct);

    state = state.copyWith(
      answers: newAnswers,
      correctAnswers: newCorrectAnswers,
      isCompleted: allCorrect,
    );
  }

  /// 次の問題へ進む
  /// - 全問正解の場合は最後の問題のまま
  void nextQuestion(Lesson lesson) {
    if (state.isCompleted) return;

    int nextIndex = state.currentQuestionIndex + 1;
    if (nextIndex >= lesson.questions.length) {
      // 全問回答済みの場合は、全問正解かどうかをチェック
      final allCorrect = state.correctAnswers.length == lesson.questions.length &&
          state.correctAnswers.every((correct) => correct);
      
      state = state.copyWith(
        isCompleted: allCorrect,
        currentQuestionIndex: lesson.questions.length - 1,
      );
    } else {
      state = state.copyWith(
        currentQuestionIndex: nextIndex,
      );
    }
  }

  /// 状態をリセット
  void reset() {
    state = const LessonState(
      answers: [],
      correctAnswers: [],
      currentQuestionIndex: 0,
      isCompleted: false,
    );
  }
}
