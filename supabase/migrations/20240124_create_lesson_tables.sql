-- lessons table
CREATE TABLE lessons (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    lesson_number INT NOT NULL UNIQUE,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    exp INT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- questions table
CREATE TABLE questions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    lesson_id UUID REFERENCES lessons(id) ON DELETE CASCADE,
    question_number INT NOT NULL,
    text TEXT NOT NULL,
    options TEXT[] NOT NULL,
    correct_index INT NOT NULL,
    explanation TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(lesson_id, question_number)
);

-- Insert initial lesson data
INSERT INTO lessons (lesson_number, title, description, exp) VALUES
(1, 'ビットコインの基礎', 'ビットコインの基本的な概念について学びましょう', 100),
(2, 'ビットコインの仕組み', 'ビットコインがどのように機能するのか、詳しく見ていきましょう', 150);

-- Get the lesson IDs
DO $$
DECLARE
    lesson1_id UUID;
    lesson2_id UUID;
BEGIN
    -- Get lesson IDs
    SELECT id INTO lesson1_id FROM lessons WHERE lesson_number = 1;
    SELECT id INTO lesson2_id FROM lessons WHERE lesson_number = 2;

    -- Insert questions for lesson 1
    INSERT INTO questions (lesson_id, question_number, text, options, correct_index, explanation)
    VALUES 
    (lesson1_id, 1, 'ビットコインとは何ですか？', 
    ARRAY['デジタル通貨の一種', '実物の金貨', '銀行が発行する紙幣', '企業の株式'],
    0, 'ビットコインは、ブロックチェーン技術を使用したデジタル通貨です。物理的な実体はありませんが、インターネットを通じて価値を転送することができます。'),

    (lesson1_id, 2, 'ビットコインの特徴として正しいものは？',
    ARRAY['中央管理者が存在する', '取引が匿名ではない', '発行数に上限がある', '取引を取り消すことができる'],
    2, 'ビットコインの重要な特徴の一つは、発行数が2100万BTCに制限されていることです。これにより、インフレーションを防ぐことができます。'),

    (lesson1_id, 3, 'ビットコインはどのように保管されますか？',
    ARRAY['銀行の金庫に保管', 'ウォレットで管理', '現金として保管', '証券会社で保管'],
    1, 'ビットコインは、デジタルウォレットで管理されます。ウォレットには、秘密鍵と公開鍵が含まれており、これらを使用して取引を行います。');

    -- Insert questions for lesson 2
    INSERT INTO questions (lesson_id, question_number, text, options, correct_index, explanation)
    VALUES 
    (lesson2_id, 1, 'ブロックチェーンとは何ですか？',
    ARRAY['データベースの一種', '暗号化ソフトウェア', 'インターネットプロバイダー', '銀行のシステム'],
    0, 'ブロックチェーンは、全ての取引記録を保持する分散型のデータベースです。これにより、取引の透明性と信頼性が確保されます。'),

    (lesson2_id, 2, 'マイニングとは何をする作業ですか？',
    ARRAY['地下からビットコインを掘り出す', '取引を承認し、新しいブロックを生成する', 'ビットコインを購入する', 'ウォレットを作成する'],
    1, 'マイニングは、複雑な数学的問題を解くことで取引を承認し、新しいブロックを生成する作業です。この作業に対して報酬としてビットコインが与えられます。'),

    (lesson2_id, 3, 'ビットコインのネットワークはどのように維持されていますか？',
    ARRAY['一つの会社が管理している', '政府が管理している', '分散型のネットワークで維持されている', '銀行が管理している'],
    2, 'ビットコインのネットワークは、世界中のノード（参加者）によって維持されている分散型のシステムです。中央管理者は存在せず、参加者全員でネットワークを維持します。');
END $$;
