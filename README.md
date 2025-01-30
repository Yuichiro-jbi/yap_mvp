# YAP MVP

YAPは、ビットコインの学習を楽しくゲーミフィケーションするFlutterアプリケーションです。

## 開発ガイドライン

### アーキテクチャ方針

1. **状態管理**
   - Riverpodを使用して状態管理を行う
   - UIが状態の責務を持ちすぎないよう、ref.watch / ref.readを用いてProviderから状態を取得・操作
   - Providerの種類はStateProvider, StateNotifierProvider, FutureProvider, StreamProviderを用途に応じて選択

2. **Widgetの実装**
   - ConsumerWidgetは使用せず、Consumerのみを使用
   - 画面全体が巨大にならないように、小分割のConsumerを使い可読性を担保
   - UIはStatelessWidgetを推奨（アニメーションなど必要な場合を除く）

3. **MVPフェーズのルール**
   - Repositoryは作成しない
   - Providerに直接ロジックを書き込む形でシンプルに実装
   - APIやDBなどの外部リソースアクセスも一時的にProviderに集約

### ディレクトリ構造
```
lib/
 ┣ main.dart
 ┣ presentation/
 ┃  ┣ home/
 ┃  ┃  ┣ home_screen.dart
 ┃  ┃  ┗ widgets/
 ┃  ┣ login/
 ┃  ┃  ┣ login_screen.dart
 ┃  ┃  ┗ widgets/
 ┃  ┗ common/
 ┃     ┗ widgets/
 ┣ provider/
 ┃  ┣ home_provider.dart
 ┃  ┗ login_provider.dart
 ┗ model/
    ┣ user.dart
    ┗ item.dart
```

### 命名規則

1. **ファイル・クラス命名**
   - UI: ○○Screen / ○○Page / ○○View
   - Provider: ○○Provider (変数名), ○○Notifier (クラス名)
   - Model: User / Item / UserModel などパスカルケース
   - Repository: （将来的に）○○Repository, ○○RepositoryImpl

2. **共通Widget Props**
   ```dart
   // LessonCard
   const LessonCard({
     required Lesson lesson,        // レッスンデータ
     required VoidCallback onTap,  // タップ時のコールバック（non-nullable）
     required bool isCompleted,    // 完了状態
     required bool isLocked,       // ロック状態（true = ロック中）
   });

   // IslanderStatsHeader
   const IslanderStatsHeader({
     required Islander islander,  // ユーザーデータ
   });
   ```

3. **プロパティ命名規則**
   - ロック状態は`isLocked`（bool）を使用（`isAvailable`は使用しない）
   - コールバック関数は基本的にnon-nullable
   - 完了状態は`isCompleted`（bool）を使用
   - データモデルは以下の命名に統一：
     - `Lesson`モデル：`experienceReward`と`coinReward`
     - `Islander`モデル：`experience`と`sats`

### コード例

```dart
// Consumerの使用例（推奨）
Widget build(BuildContext context) {
  return Consumer(
    builder: (context, ref, child) {
      final data = ref.watch(dataProvider);
      return MyWidget(data: data);
    },
  );
}

// LessonCardの使用例
LessonCard(
  lesson: lesson,
  onTap: handleTap,
  isCompleted: true,
  isLocked: false,
)
```

## セットアップ

1. 必要な環境
   - Flutter 3.x
   - Dart 3.x

2. インストール
   ```bash
   flutter pub get
   ```

3. 実行
   ```bash
   flutter run
   ```

## 開発フロー

1. 機能開発
   - 新機能は`feature/`ブランチで開発
   - UIコンポーネントは`presentation/`ディレクトリに配置
   - 状態管理は`provider/`ディレクトリに配置

2. コードレビュー
   - PRを作成する前にフォーマットを確認
   - 命名規則に従っているか確認
   - Consumerの使用方法が適切か確認

3. テスト
   - Widget テスト
   - Provider テスト
   - 統合テスト
