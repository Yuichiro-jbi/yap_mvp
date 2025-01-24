// Islanderの基本的なデータ構造を定義するファイル
class Islander {
  final String? id;           // Supabase用のID（nullableなので?をつける）
  final int exp;             // 経験値
  final int sats;            // 獲得したSats
  final int loginDays;       // ログイン日数
  final DateTime createdAt;   // アカウント作成日
  final int learningProgress; // 学習進捗（完了したレッスン数）

  const Islander({
    this.id,
    required this.exp,
    required this.sats,
    required this.loginDays,
    required this.createdAt,
    required this.learningProgress,
  });

  // コピーメソッド
  Islander copyWith({
    String? id,
    int? exp,
    int? sats,
    int? loginDays,
    DateTime? createdAt,
    int? learningProgress,
  }) {
    return Islander(
      id: id ?? this.id,
      exp: exp ?? this.exp,
      sats: sats ?? this.sats,
      loginDays: loginDays ?? this.loginDays,
      createdAt: createdAt ?? this.createdAt,
      learningProgress: learningProgress ?? this.learningProgress,
    );
  }

  // JSONからIslanderを生成するファクトリメソッド
  factory Islander.fromJson(Map<String, dynamic> json) {
    print('Parsing JSON: $json'); // デバッグ用
    return Islander(
      id: json['id'] as String?,
      exp: json['exp'] as int,
      sats: json['sats'] as int,
      loginDays: json['login_days'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      learningProgress: json['learning_progress'] as int,
    );
  }

  // IslanderをJSONに変換するメソッド
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'exp': exp,
      'sats': sats,
      'login_days': loginDays,
      'created_at': createdAt.toIso8601String(),
      'learning_progress': learningProgress,
    };
  }

  // 初期値を持つファクトリコンストラクタ
  factory Islander.initial() {
    return Islander(
      exp: 0,
      sats: 0,
      loginDays: 1,
      createdAt: DateTime.now(),
      learningProgress: 0, // 初期値を0に変更
    );
  }
}
