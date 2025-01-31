import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/lesson.dart';
import '../model/question.dart';
import 'islander_provider.dart';

final lessonNotifierProvider = StateNotifierProvider<LessonNotifier, List<Lesson>>((ref) {
  return LessonNotifier();
});

class LessonNotifier extends StateNotifier<List<Lesson>> {
  LessonNotifier() : super([
    Lesson(
      id: '1',
      title: 'ビットコインとは',
      description: 'ビットコインの基本概念を学びましょう',
      experienceReward: 100,
      coinReward: 1000,
      questions: [
        Question(
          id: '1_1',
          question: 'ビットコインを作った人物は誰でしょうか？',
          options: ['サトシ・ナカモト', 'イーロン・マスク', 'マーク・ザッカーバーグ', 'スティーブ・ジョブズ'],
          correctAnswerIndex: 0,
          explanation: 'ビットコインは2008年にサトシ・ナカモトという匿名の人物によって考案されました。',
        ),
      ],
    ),
    Lesson(
      id: '2',
      title: 'ウォレットの基礎',
      description: 'ビットコインウォレットの使い方を学びましょう',
      experienceReward: 150,
      coinReward: 1500,
      questions: [
        Question(
          id: '2_1',
          question: 'ビットコインウォレットの秘密鍵を紛失した場合、どうなりますか？',
          options: ['資金が永久に失われる', '取引所に連絡すれば復元できる', '政府に申請すれば復元できる', 'インターネットから再ダウンロードできる'],
          correctAnswerIndex: 0,
          explanation: '秘密鍵は資金へのアクセスを可能にする唯一の方法です。紛失すると資金を永久に失うことになります。',
        ),
      ],
    ),
    Lesson(
      id: '3',
      title: 'ブロックチェーンの仕組み',
      description: 'ブロックチェーン技術の基本を理解しましょう',
      experienceReward: 200,
      coinReward: 2000,
      questions: [
        Question(
          id: '3_1',
          question: 'ビットコインのブロックチェーンで、新しいブロックが生成される平均時間は？',
          options: ['10分', '1時間', '1日', '1週間'],
          correctAnswerIndex: 0,
          explanation: 'ビットコインのブロックチェーンでは、約10分ごとに新しいブロックが生成されるように設計されています。',
        ),
      ],
    ),
    Lesson(
      id: '4',
      title: 'マイニングの基本',
      description: 'ビットコインマイニングについて学びましょう',
      experienceReward: 250,
      coinReward: 2500,
      questions: [
        Question(
          id: '4_1',
          question: 'ビットコインのマイニングで使用される合意形成アルゴリズムは？',
          options: ['Proof of Work', 'Proof of Stake', 'Proof of Authority', 'Delegated Proof of Stake'],
          correctAnswerIndex: 0,
          explanation: 'ビットコインはProof of Work（作業証明）を使用して、新しいブロックの追加を検証します。',
        ),
      ],
    ),
    Lesson(
      id: '5',
      title: 'セキュリティ対策',
      description: '安全な資産管理方法を学びましょう',
      experienceReward: 300,
      coinReward: 3000,
      questions: [
        Question(
          id: '5_1',
          question: '最も安全なビットコインの保管方法は？',
          options: ['コールドウォレット', 'ホットウォレット', '取引所', 'スマートフォンアプリ'],
          correctAnswerIndex: 0,
          explanation: 'コールドウォレットはインターネットに接続されていないため、ハッキングのリスクが最も低い保管方法です。',
        ),
      ],
    ),
    Lesson(
      id: '6',
      title: '取引の基本',
      description: 'ビットコインの送受信について学びましょう',
      experienceReward: 350,
      coinReward: 3500,
      questions: [
        Question(
          id: '6_1',
          question: 'ビットコインの取引手数料は何によって決まりますか？',
          options: ['ネットワークの混雑状況', '送金額', '受取人の場所', '送金時刻'],
          correctAnswerIndex: 0,
          explanation: '取引手数料は主にネットワークの混雑状況によって変動します。混雑時は手数料が高くなります。',
        ),
      ],
    ),
    Lesson(
      id: '7',
      title: 'Lightning Network',
      description: 'ライトニングネットワークについて学びましょう',
      experienceReward: 400,
      coinReward: 4000,
      questions: [
        Question(
          id: '7_1',
          question: 'Lightning Networkの主な目的は？',
          options: ['取引の高速化とスケーラビリティの向上', 'マイニング報酬の増加', 'セキュリティの向上', 'プライバシーの保護'],
          correctAnswerIndex: 0,
          explanation: 'Lightning Networkは、ビットコインのスケーラビリティ問題を解決し、即時かつ低コストの取引を可能にします。',
        ),
      ],
    ),
    Lesson(
      id: '8',
      title: '税金と法規制',
      description: 'ビットコインに関する法律を学びましょう',
      experienceReward: 450,
      coinReward: 4500,
      questions: [
        Question(
          id: '8_1',
          question: '日本でビットコインは法的に何として認められていますか？',
          options: ['決済手段として利用可能な財産的価値', '法定通貨', '有価証券', '商品'],
          correctAnswerIndex: 0,
          explanation: '日本では資金決済法により、ビットコインは決済手段として利用可能な財産的価値として認められています。',
        ),
      ],
    ),
    Lesson(
      id: '9',
      title: '投資戦略',
      description: '長期投資の考え方を学びましょう',
      experienceReward: 500,
      coinReward: 5000,
      questions: [
        Question(
          id: '9_1',
          question: 'ビットコイン投資でよく使われる「HODL」とは何を意味しますか？',
          options: ['長期保有戦略', '短期売買戦略', 'レバレッジ取引', 'マイニング戦略'],
          correctAnswerIndex: 0,
          explanation: 'HODLは「Hold On for Dear Life」の略で、価格変動に関係なく長期保有を続ける戦略を指します。',
        ),
      ],
    ),
    Lesson(
      id: '10',
      title: '将来の展望',
      description: 'ビットコインの未来について考えましょう',
      experienceReward: 550,
      coinReward: 5500,
      questions: [
        Question(
          id: '10_1',
          question: 'ビットコインの総発行量の上限は？',
          options: ['2100万BTC', '1000万BTC', '5000万BTC', '無制限'],
          correctAnswerIndex: 0,
          explanation: 'ビットコインは2100万BTCという固定された総発行量を持ち、これ以上増えることはありません。',
        ),
      ],
    ),
  ]);

  // レッスンを取得
  Lesson getLesson(String id) {
    return state.firstWhere((lesson) => lesson.id == id);
  }

  // 正解数をカウント
  int countCorrectAnswers(String lessonId, Map<String, int> answers) {
    final lesson = getLesson(lessonId);
    int correctCount = 0;

    for (var question in lesson.questions) {
      final userAnswer = answers[question.id];
      if (userAnswer != null && userAnswer == question.correctAnswerIndex) {
        correctCount++;
      }
    }

    return correctCount;
  }
}
