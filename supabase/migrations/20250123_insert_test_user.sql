-- テストユーザーのデータを作成
INSERT INTO islanders (
  islander_id,
  exp,
  sats,
  login_days,
  learning_progress,
  created_at
) VALUES (
  'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11',  -- テストユーザーのID
  25,               -- 経験値
  50,               -- Sats
  1,                -- ログイン日数
  20,               -- 学習進捗（20%）
  now()             -- 作成日時
) ON CONFLICT (islander_id) 
DO UPDATE SET
  exp = EXCLUDED.exp,
  sats = EXCLUDED.sats,
  login_days = EXCLUDED.login_days,
  learning_progress = EXCLUDED.learning_progress;
