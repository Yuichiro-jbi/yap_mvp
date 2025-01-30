# YAP共通Widgetガイドライン

## 共通コンポーネントの型定義

### LessonCard
レッスンカードの表示に使用するWidget
```dart
const LessonCard({
  required Lesson lesson,        // レッスンデータ
  required VoidCallback onTap,  // タップ時のコールバック（non-nullable）
  required bool isCompleted,    // 完了状態
  required bool isLocked,       // ロック状態（true = ロック中）
});
```

### IslanderStatsHeader
ユーザーの統計情報を表示するヘッダーWidget
```dart
const IslanderStatsHeader({
  required Islander islander,  // ユーザーデータ
});
```

## 命名規則とプロパティの型

### 1. ロック状態の表現
- `isLocked`（bool）を使用する
- ❌ `isAvailable`は使用しない
- `true`の場合がロック中、`false`の場合が利用可能

### 2. コールバック関数
- 基本的にnon-nullableな`VoidCallback`型を使用
- ロック状態の制御はWidget内部で行う
- 例：`onTap: isLocked ? null : onTap`

### 3. 完了状態の表現
- `isCompleted`（bool）を使用
- `true`の場合が完了、`false`の場合が未完了

### 4. データモデルのプロパティ命名
- `Lesson`モデル
  - 経験値報酬：`experienceReward`
  - コイン報酬：`coinReward`
- `Islander`モデル
  - 経験値：`experience`
  - コイン：`sats`

## 使用例

```dart
// 正しい使用例
LessonCard(
  lesson: lesson,
  onTap: handleTap,
  isCompleted: true,
  isLocked: false,
)

// 間違った使用例
LessonCard(
  lesson: lesson,
  onTap: isAvailable ? handleTap : null,  // ❌ コールバックのnull制御をWidget外で行っている
  isCompleted: true,
  isAvailable: true,  // ❌ 非推奨のプロパティ名
)
```
