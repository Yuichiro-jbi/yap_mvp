import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/lesson.dart';

final lessonServiceProvider = StateNotifierProvider<LessonService, List<Lesson>>((ref) {
  return LessonService();
});

class LessonService extends StateNotifier<List<Lesson>> {
  LessonService()
      : super([
          Lesson(
            id: 'lesson1',
            lessonNumber: 1,
            title: 'ビットコインの基礎',
            description: 'ビットコインの基本的な概念について学びましょう',
            exp: 100,
            questions: [
              Question(
                id: 'q1',
                text: 'ビットコインとは何ですか？',
                options: [
                  'デジタル通貨の一種',
                  '実物の金貨',
                  '銀行が発行する紙幣',
                  '企業の株式',
                ],
                correctIndex: 0,
              ),
              Question(
                id: 'q2',
                text: 'ビットコインの特徴として正しいものは？',
                options: [
                  '中央管理者が存在する',
                  '取引が匿名ではない',
                  '発行数に上限がある',
                  '取引を取り消すことができる',
                ],
                correctIndex: 2,
              ),
              Question(
                id: 'q3',
                text: 'ビットコインはどのように保管されますか？',
                options: [
                  '銀行の金庫に保管',
                  'ウォレットで管理',
                  '現金として保管',
                  '証券会社で保管',
                ],
                correctIndex: 1,
              ),
            ],
            explanations: {
              'q1': 'ビットコインは、ブロックチェーン技術を使用したデジタル通貨です。物理的な実体はありませんが、インターネットを通じて価値を転送することができます。',
              'q2': 'ビットコインの重要な特徴の一つは、発行数が2100万BTCに制限されていることです。これにより、インフレーションを防ぐことができます。',
              'q3': 'ビットコインは、デジタルウォレットで管理されます。ウォレットには、秘密鍵と公開鍵が含まれており、これらを使用して取引を行います。',
            },
          ),
          Lesson(
            id: 'lesson2',
            lessonNumber: 2,
            title: 'ビットコインの仕組み',
            description: 'ビットコインがどのように機能するのか、詳しく見ていきましょう',
            exp: 150,
            questions: [
              Question(
                id: 'q1',
                text: 'ブロックチェーンとは何ですか？',
                options: [
                  'データベースの一種',
                  '暗号化ソフトウェア',
                  'インターネットプロバイダー',
                  '銀行のシステム',
                ],
                correctIndex: 0,
              ),
              Question(
                id: 'q2',
                text: 'マイニングとは何をする作業ですか？',
                options: [
                  '地下からビットコインを掘り出す',
                  '取引を承認し、新しいブロックを生成する',
                  'ビットコインを購入する',
                  'ウォレットを作成する',
                ],
                correctIndex: 1,
              ),
              Question(
                id: 'q3',
                text: 'ビットコインのネットワークはどのように維持されていますか？',
                options: [
                  '一つの会社が管理している',
                  '政府が管理している',
                  '分散型のネットワークで維持されている',
                  '銀行が管理している',
                ],
                correctIndex: 2,
              ),
            ],
            explanations: {
              'q1': 'ブロックチェーンは、全ての取引記録を保持する分散型のデータベースです。これにより、取引の透明性と信頼性が確保されます。',
              'q2': 'マイニングは、複雑な数学的問題を解くことで取引を承認し、新しいブロックを生成する作業です。この作業に対して報酬としてビットコインが与えられます。',
              'q3': 'ビットコインのネットワークは、世界中のノード（参加者）によって維持されている分散型のシステムです。中央管理者は存在せず、参加者全員でネットワークを維持します。',
            },
          ),
        ]);

  Lesson getLesson(int lessonNumber) {
    return state.firstWhere(
      (lesson) => lesson.lessonNumber == lessonNumber,
      orElse: () => throw Exception('Lesson not found'),
    );
  }

  List<Lesson> getAllLessons() {
    return state;
  }

  bool isLessonUnlocked(int lessonNumber, int learningProgress) {
    // 最初のレッスンは常にアンロック
    if (lessonNumber == 1) return true;
    
    // 前のレッスンまで完了していて、EXP値が十分にある場合にアンロック
    // learningProgressが0の場合は最初のレッスンのみアクセス可能
    return learningProgress >= lessonNumber - 1;
  }
}
