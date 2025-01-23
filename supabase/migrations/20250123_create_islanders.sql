-- テーブルを作成
CREATE TABLE IF NOT EXISTS islanders (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  islander_id UUID NOT NULL,
  exp INTEGER NOT NULL DEFAULT 0,
  sats INTEGER NOT NULL DEFAULT 0,
  login_days INTEGER NOT NULL DEFAULT 1,
  learning_progress INTEGER NOT NULL DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- RLSを有効化
ALTER TABLE islanders ENABLE ROW LEVEL SECURITY;

-- 認証済みユーザーが自分のデータを読み取れるポリシー
DROP POLICY IF EXISTS "Users can view own data" ON islanders;
CREATE POLICY "Users can view own data" ON islanders
  FOR SELECT USING (true);  -- 全てのデータを読み取り可能に

-- 認証済みユーザーが自分のデータを更新できるポリシー
DROP POLICY IF EXISTS "Users can update own data" ON islanders;
CREATE POLICY "Users can update own data" ON islanders
  FOR UPDATE USING (true)
  WITH CHECK (true);  -- 全てのデータを更新可能に

-- 認証済みユーザーが自分のデータを作成できるポリシー
DROP POLICY IF EXISTS "Users can insert own data" ON islanders;
CREATE POLICY "Users can insert own data" ON islanders
  FOR INSERT WITH CHECK (true);  -- 全てのデータを挿入可能に

-- updated_atを自動更新するトリガー
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_islanders_updated_at
  BEFORE UPDATE ON islanders
  FOR EACH ROW
  EXECUTE PROCEDURE update_updated_at_column();
