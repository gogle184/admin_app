class CreateMKeywords < ActiveRecord::Migration[7.0]
  def change
    create_table :m_keywords do |t|
      t.string :keyowrd, null: false, default: "", comment: "キーワード"
      t.text :word, null: false, default: "", comment: "ワード(カンマ区切りで入力)"

      t.timestamps
    end
  end
end

#【マスタ】コンテンツを検索するための情報(キーワード) m_keyword
